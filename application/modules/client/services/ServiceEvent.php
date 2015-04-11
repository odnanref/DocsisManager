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
 * Description of ServiceEvent
 *
 * @author andref
 * @version $Id$
 */
class Client_Service_ServiceEvent extends Event
{
    private $pack = null;
    
    public function setPack($pack)
    {
        $this->pack = $pack;
    }
    
    public function getPack()
    {
        return $this->pack;
    }
    
    private $_hasnet = false;
    
    public function setHasNet($flag)
    {
        $this->_hasnet = (boolean) $flag;
    }
    
    public function getHasNet()
    {
        return $this->_hasnet;
    }
    
    private $_hasphone = false;
    
    public function setHasPhone($flag)
    {
        $this->_hasphone = (boolean) $flag;
    }
    
    public function getHasPhone()
    {
        return $this->_hasphone;
    }
    
    private $_onefilemta = false;
    
    public function setOneFileMta($flag)
    {
        $this->_onefilemta = (boolean) $flag;
    }
    
    public function getOneFileMta()
    {
        return $this->_onefilemta;
    }
    
    private $_modem = null;
    
    public function getModem()
    {
        return $this->_modem;
    }
    
    public function setModem($modem)
    {
        $this->_modem = $modem;
    }
    // Service pack
    // config details
    // speed up + down
    // phone service -> line (1,2) number
    // cfg file + cfg file mta
    public function __construct($pack = null )
    {
        if (!is_object($pack) && $pack !== null ) {
            throw new Zend_Exception("Valor não esperado obtido no evento " .
                    __CLASS__);
        }
        
        if ($pack !== null ) {
            $this->setPack($pack);   
        }
    }
}
