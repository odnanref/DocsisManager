<?php

/**
 * This file belongs to the Docsis Manager for managing ISC dhcp and
 * docsis server table (docsismodem) for a cable network it provides some
 * utilization and information gathering tools for easy management of the cable
 * modem network and provision of CPE and other ISP related equipments.
 *
 * Copyright (C) 2011  Fernando André <netriver at gmail dot com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 */

/**
 * This class was obtained and changed by me from an online repo
 *
 * //FIXME add copyright for this
 */

class ErrorController extends Zend_Controller_Action {

    private $_notifier;
    private $_error;
    private $_environment;
    private $alertMailConfig = array();

    public function preDispatch()
    {
        $bootstrap = $this->getInvokeArg("bootstrap");
        $aConfig = $bootstrap->getOptions();

        $this->alertMailConfig = array(
            "server"    => $aConfig["emailalert"]["server"],
            "username"  => $aConfig["emailalert"]["username"],
            "password"  => $aConfig["emailalert"]["password"],
            "ssl"       => $aConfig["emailalert"]["ssl"],
            "port"      => $aConfig["emailalert"]["port"],
            "transport" => $aConfig["emailalert"]["transport"],
            "from"      => $aConfig["emailalert"]["from"],
            "to"        => $aConfig["emailalert"]["to"]
        );

        $mailer = new Zend_Mail();

        if ($this->alertMailConfig["transport"]) {
            $tr = new Zend_Mail_Transport_Smtp($this->alertMailConfig["transport"]);
            // Eventually support outside hosts.
            $mailer->setDefaultTransport($tr);
        }

        if (is_string($this->alertMailConfig["from"])) {
            $mailer->setFrom($this->alertMailConfig["from"]);
        }

        if (is_array($this->alertMailConfig["to"])) {
            foreach ($this->alertMailConfig["to"] as $to) {
                if (is_string($to)) {
                    $mailer->addTo($to);
                }
            }
        }

        $environment = $bootstrap->getEnvironment();
        $error = $this->_getParam('error_handler');

        $session = new Zend_Session_Namespace();
        $database = $bootstrap->getResource('db');
        $profiler = $database->getProfiler();

        $this->_notifier = new Far_Service_Notifier_Error(
                        $environment,
                        $error,
                        $mailer,
                        $session,
                        $profiler,
                        $_SERVER
        );

        $this->_error = $error;
        $this->_environment = $environment;

        parent::preDispatch();
    }

    public function errorAction()
    {
        switch ($this->_error->type) {
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_CONTROLLER:
            case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_ACTION:
                $this->getResponse()->setHttpResponseCode(404);
                $this->view->message = 'Page not found';
                break;

            default:
                $this->getResponse()->setHttpResponseCode(500);
                $this->_applicationError();
                break;
        }

// Log exception, if logger available
        if ($log = $this->_getLog()) {
            $log->crit($this->view->message, $this->_error->exception);
        }
    }

    private function _applicationError()
    {
        $fullMessage = $this->_notifier->getFullErrorMessage();
        $shortMessage = $this->_notifier->getShortErrorMessage();

        switch ($this->_environment) {
            case 'production':
                $this->view->message = $shortMessage;
                break;
            case 'development':
                $this->_helper->layout->setLayout('blank');
                $this->_helper->viewRenderer->setNoRender();

                $this->getResponse()->appendBody($shortMessage);
                $this->view->message = $shortMessage;
                break;
            default:
                $this->view->message = nl2br($fullMessage);
        }

        $this->_notifier->notify();
    }

    private function _getLog()
    {
        $bootstrap = $this->getInvokeArg('bootstrap');
        if (!$bootstrap->hasPluginResource('Log')) {
            return false;
        }
        $log = $bootstrap->getResource('Log');
        return $log;
    }

}
