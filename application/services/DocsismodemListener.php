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

use Symfony\Component\EventDispatcher\Event;

/**
 * DocsismodemListener listen for events from other modules in the application
 * act on new equipment insert in order to accelarate cm activation
 *
 * @author andref
 * @version $Id$
 */
class DM_Service_DocsismodemListener
{
    public function onEquipment(Client_Service_EquipmentEvent $event)
    {
        foreach ($event->getEquipmentList() as $equipment ) {
            $type = $equipment->findParentRow("Client_Model_Typeequipment");
            if ($type->code != 'MODEM') {
                continue;
            }

            $datain = new DateTime($equipment->datain);
            if ( $datain->format('Y-m-d') == date("Y-m-d") ) {
                $dm = new DM_Model_Docsismodems();
                $dm->newEquipment($equipment);
            }
        }

    }

    public function onService(Client_Service_ServiceEvent $event)
    {
        $options = array(
            "pack"          => $event->getPack()
            ,"onefilemta"   => $event->getOneFileMta()
            ,"hasphone"     => $event->getHasPhone()
            ,"hasnet"       => $event->getHasNet()
            ,"modem"        => $event->getModem()
        );

        $cfg = new DM_Service_DocsisCfgSetup($options);
        $cfg->init();
    }

    public function onClient($event)
    {

    }

    public function onNew(DM_Service_DocsismodemEvent $event)
    {
        $modem = $event->getDocsismodem();

        $hist = new DM_Model_DMhistory();

        $Data = array_merge($modem->toArray(), ["user" => $this->getUser()->login], array("action" => "new") );

        $hist->saveData($Data);
    }

    public function onUpdate(DM_Service_DocsismodemEvent $event)
    {
        $modem = $event->getDocsismodem();

        $hist = new DM_Model_DMhistory();

        $Data = array_merge($modem->toArray(), ["user" => $this->getUser()->login], array("action" => "update") );

        $hist->saveData($Data);
    }

    public function getUser()
    {
        return \Users_Plugin_Auth::getInstance()->getIdentity();
    }

}
