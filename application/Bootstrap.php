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
 * Controlls what gets loaded on the webapp
 *
 * @author andref <netriver at gmail dot com >
 */
class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    /**
     * EventDispatcher Symfony
     *
     * @var \Symfony\Component\EventDispatcher\EventDispatcher
     */
    public $eventDispatcher = null;

    /**
     * Get the event dispatcher
     *
     * @return \Symfony\Component\EventDispatcher\EventDispatcher
     */
    public function _getEventDispatcher()
    {
        return $this->eventDispatcher;
    }

    public function run()
    {
        $dispatcher = $this->getResource("Far_Resource_EventDispatcher");

        $dispatcher->dispatch("bootstrap.prerun", null);

        $dmlistener = new DM_Service_DocsismodemListener();

        $dispatcher->addListener(
                "client.equipment.update",
                array($dmlistener, 'onEquipment')
                );

        $dispatcher->addListener(
                "client.equipment.insert",
                array($dmlistener, 'onEquipment')
                );

        $dispatcher->addListener(
                "service.alter",
                array($dmlistener, 'onService')
                );

        $dispatcher->addListener(
                "client.disable",
                array($dmlistener, 'onClient')
                );

        $dispatcher->addListener(
                "docsismodem.new",
                array($dmlistener, 'onNew')
                );

        $dispatcher->addListener(
                "docsismodem.update",
                array($dmlistener, 'onUpdate')
                );

        parent::run();

        $dispatcher->dispatch("bootstrap.postrun", null);

    }

    protected function _initResourceLoader()
    {
        $this->_resourceLoader->addResourceType('service', 'services', 'Service');
        $this->_resourceLoader->addResourceType('serviceplugin', 'services/plugins', 'Service_Plugin');
    }

    protected function _initPlugins()
	{
		$loader = new Zend_Application_Module_Autoloader(
            array(
                'namespace' => 'Users',
                'basePath'  => APPLICATION_PATH . '/modules/users',
            ));
	}

}