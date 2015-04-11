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

use \Symfony\Component\EventDispatcher\Event;

/**
 * Description of NewEquipmentEvent
 *
 * @author andref
 * @version $Id$
 */
class Client_Service_EquipmentEvent extends Event
{
    private static $eventTypes = array('insert', 'update' ,'delete', 'disable');
    
    private $equipmentList = array();
    
    public function getEquipmentList()
    {
        return $this->equipmentList;
    }
        
    public function __construct($options = array())
    {
        if (count($options) > 0 ) {
            if (array_key_exists("list", $options) && is_array($options['list'])) {
                $this->equipmentList = $options['list'];
            }
            
            if (array_key_exists("device", $options) && is_array($options['device'])) {
                $this->equipmentList[] = $options['device'];
            }
            
            if (array_key_exists("eventType", $options)) {
                $this->eventType = $options['eventType'];
            }
        }
    }
    
    public function __set($name, $value)
    {
        if ($name == 'eventType') {
            if (!in_array($value, self::eventTypes)) {
                throw new Zend_Exception("Unknown event type $value");
            }
        }
    }
}
