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
 * Description of Cliente
 *
 *
 * @author andref
 * @copyright 2011 Fernando André < netriver at gmail.com > under license GPLv2
 * @version $Id$
 */
class Client_Model_Clients extends Zend_Db_Table_Abstract
{
    protected $_name        = "client";
    protected $_primary     = "idclient";
    protected $_rowClass    = 'Client_Model_Client';
    protected $_sequence    = true;
    
    protected $_referenceMap = array(
        "Servico"   => array(
          "columns"  => "idequipment",
          "refTableClass"   => "Client_Model_Equipment",
          "refColumns"      => "idequipment"
        )
    );
    
    public function getActives()
    {
        $sel = $this->select();
        $sel->setIntegrityCheck(false);

        $fields = array(
            "idclient", "name", "contract", "node", "state", "datain"
        );
        $sel->from($this->_name, $fields);
        return $this->fetchAll($sel);
    }
    
    /**
     * This here code uses group by idclient to only return one client
     * 
     * @param array $data
     * @return Zend_Db_Table_Rowset
     */
    public function search(array $data)
    {
        $sel = $this->select();
        $sel->setIntegrityCheck(false);
        $sel->from($this->_name);
        $sel->joinInner("equipment", "equipment.idclient = client.idclient ", array() );
        $sel->joinInner("service", "service.idequipment = equipment.idequipment", array( ));
        $sel->where("equipment.dataout IS NULL OR equipment.dataout = '0000-00-00 00:00:00'");
        $sel->where("service.dataunactive IS NULL OR service.dataunactive = '0000-00-00 00:00:00'");
        
        foreach ($data as $key => $value ) {
            if (empty($value))
                continue;
            
            if ($key == 'phone ') {
                $sel->where("$key = ? ", $value)->orWhere("service.tel = ? ", $value);
            } else {
                if ($key == 'name')
                    $key = "client.name";
                
                if ($key == 'node')
                    $key = "client.node";
                
                $sel->where("$key = ? ", $value);
            }
        }
        
        $sel->group("idclient");
        
        return $this->fetchAll($sel);
    }
}
