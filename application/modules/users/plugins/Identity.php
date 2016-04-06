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
 * Identity plugin
 * 
 * @author andref
 * @version $Id$
 */

/**
 * This loads a user identity to the request so access can be determined
 */
class Users_Plugin_Identity extends Zend_Controller_Plugin_Abstract
{
	private $_controller;
	private $_module;
	private $_action;
	private $_role;

	public function preDispatch(Zend_Controller_Request_Abstract $request)
	{
		$redirect = true;
		$this->_controller	= $this->getRequest()->getControllerName();
		$this->_module		= $this->getRequest()->getModuleName();
		$this->_action		= $this->getRequest()->getActionName();

		$user = null;

        if ($this->_module == 'users' && 
                $this->_controller == 'user' && 
            in_array($this->_action, Users_Plugin_Access::$authpages) ) 
        {
			$request->setModuleName('users');
			$request->setControllerName('user');
		} else {
            // Do access control
            $auth = Users_Plugin_Auth::getInstance();
            if($auth->hasIdentity() === true ) {
                $us     = new Users_Model_Users();
                $user   = $us->fetchRow("idacuser = ".(int)
                            $auth->getIdentity()->idacuser
                        );
                $redirect = false;
            }
        }

		if ($redirect === true) {
			$request->setModuleName('users');
			$request->setControllerName('user');
			$request->setActionName('login');
		}

		$request->setParam('user', $user);
	}
}
