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
 * Access control for plugin
 *
 * @author andref
 * @version $Id$
 */
class Users_Plugin_Access extends Zend_Controller_Plugin_Abstract
{
    public static $authpages = array('login', 'loginscreen');

    public function preDispatch(Zend_Controller_Request_Abstract $request)
    {
        if (!$this->_accessValid($request)) {
            //we throw an exception because the error controller
            //can easily handle these
            //throw new Users_Model_Exception_AccessDenied('Access denied');
            $request->setParam("login", $user = $request->getParam('user', null));
            $request->setModuleName("users");
            $request->setControllerName("error");
            $request->setActionName("accessdenied");
        }
    }

    private function _accessValid(Zend_Controller_Request_Abstract $request)
    {
        $user = $request->getParam('user', null);
        //the identityloader plugin should have added a user to
        //the request and if it doesn't exist something is wrong

        $this->_controller  = $this->getRequest()->getControllerName();
        $this->_module      = $this->getRequest()->getModuleName();
        $this->_action      = $this->getRequest()->getActionName();

        $params = $request->getParams();

        if ($this->_module == 'users' &&
                $this->_controller == 'user' &&
            in_array($this->_action, Users_Plugin_Access::$authpages) )
        {
			return true;
		}

        $factory = new Users_Plugin_AclFactory();
        $resource = null;

        $pri    = new \Users_Model_Privileges();
        $grpusr = new \Users_Model_UsersGroups();

        foreach (
        $user->findManyToManyRowset("Users_Model_Groups", "Users_Model_UsersGroups")
        as $g) {
            foreach ($g->findDependentRowset("Users_Model_Privileges") as $priv )
            {
                if ( ($priv->modulename == $this->_module || $priv->modulename == '*') &&
                        ($this->_controller == $priv->controllername || $priv->controllername == '*' )
                    )
                {
                    if ($this->_action == $priv->controlleraction || $priv->controlleraction == '*') {
                        setcookie("username", Users_Plugin_Auth::getInstance()->getIdentity()->name);
                        return true;
                    }
                }
            }
        }

        return false;
    }

}
