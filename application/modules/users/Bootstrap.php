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
 * Bootstrap for users module
 *
 * @author andref
 * @version $Id$
 */
class Users_Bootstrap extends Zend_Application_Module_Bootstrap
{
    protected function _initResourceLoader()
    {
        $this->_resourceLoader->addResourceType('service', 'services', 'Users_Service');
        $this->_resourceLoader->addResourceType('serviceplugin', 'services/plugins', 'Users_Service_Plugin');
    }

}

/**
 * 
 * protected function _initPlugins() 
	{	
		$loader = new Zend_Application_Module_Autoloader(
            array(
                'namespace' => 'Users',
                'basePath'  => APPLICATION_PATH . '/modules/users',
            ));
	}
 * 
 * To the main bootstrap add above code
 * 
 */