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
 * Description of LastRegisted
 *
 * @author andref
 * @version $Id$
 */
class DM_Form_LastRegisted extends Zend_Dojo_Form
{ 
    private $_macaddr;
    
    public function __construct($options = array())
    {
        if (array_key_exists("macaddr", $options)) {
            $this->_macaddr = $options['macaddr'];
        }
        parent::__construct($options);
    }
    
    public function init()
    {        
        $this->setMethod("POST");
        $this->setAction("/docsismodem/getlastlease/");
        
        $this->setName("lastlease");
        $this->setIsArray(true);
        
        $mac = new Zend_Form_Element_Hidden("id");
        if ($this->_macaddr !== null ) {
            $mac->setValue($this->_macaddr);
        }
        $this->addElement($mac);
        
        $day = new Zend_Dojo_Form_Element_DateTextBox("date");
        $day->setLabel("Data");
        $this->addElement($day);
                
        $se = new Zend_Dojo_Form_Element_Button("search");
        $se->setLabel("Procurar");
        $se->setIgnore(true);
        $se->setAttrib("onClick", "lastlease();");
        
        $this->addElement($se);
        
        return $this;
    }
    
    public function toRxTx()
    {
        $elm = $this->getElement("search");
        $elm->setAttrib("onClick", "txrxview();");
        $this->setAction("/docsismodem/gettxrx/")
                ->setName("txrx");
        
        return $this;
    }
}
