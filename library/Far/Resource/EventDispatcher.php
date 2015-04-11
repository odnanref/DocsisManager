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
 * Description of EventDispatcher
 *
 * @author andref
 * @version $Id$
 */
class Far_Resource_EventDispatcher extends Zend_Application_Resource_ResourceAbstract
{
    private $_dispatcher = null;
    
    public function init()
    {
        if ($this->_dispatcher === null ) {
            require APPLICATION_PATH . 
                '/../library/Symfony/Component/EventDispatcher/EventDispatcher.php';
        
            $dispatcher = new \Symfony\Component\EventDispatcher\EventDispatcher();
        } else {
            $dispatcher = $this->_dispatcher;
        }
        $this->getBootstrap()->eventDispatcher = $dispatcher;
        
        return $dispatcher;
        
    }
}
