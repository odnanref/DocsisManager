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
 * Description of Servico
 *
 * Gerir servicos de um cliente
 *
 * @author andref
 * @copyright 2011 Fernando André < netriver at gmail.com > under license GPLv2
 */
class Client_Model_Services extends Zend_Db_Table_Abstract
{

    protected $_name        = "service";
    protected $_primary     = "idservice";
    protected $_rowClass    = 'Client_Model_Service';
    protected $_sequence    = true;
    
    protected $_referenceMap = array(
        "pack" => array(
            "columns" => "idpack",
            "refTableClass" => "Client_Model_Pack",
            "refColumns" => "idpack"
        ),
        "equipment" => array(
            "columns" => "idequipment",
            "refTableClass" => "Client_Model_Equipment",
            "refColumns" => "idequipment"
        )
    );

    public function cancel($id, $data = null)
    {
        if ($data === null || $data == "0000-00-00 00:00:00") {
            $data = date("Y-m-d H:i:s");
        }
        
        return $this->update(array("dataunactive" => $data), "idservice = " . (int) $id);
    }

    public function getServices($idclient, $state = 'active', $type = null)
    {
        $sel = $this->select()->from($this->_name, array('idservice', 
            'dataactive', 'dataunactive'));
        
        $sel->setIntegrityCheck(false);
        
        $sel->joinInner(
                "equipment", 
                "equipment.idequipment = service.idequipment",
                array("macaddr", "serialnum","datain", "dataout")
                );
                
        $sel->joinInner("pack", "pack.idpack = service.idpack",array(
                    "service" => "name", 
                    "service_description" => "description")
                );                
        
        if ($type !== null) {
            if ($type == 'internet') {
                $sel->where("tel is null OR tel <= 0 ");
            } else {
                $sel->where("tel is not null AND tel > 0 ");
            }
        }
        
        $sel->where("idclient = " . (int) $idclient);
        
        switch ($state) {
            case 'active': {
                    $sel->where("( service.dataunactive IS NULL OR 
                    service.dataunactive > NOW() OR 
                    service.dataunactive = '0000-00-00 00:00:00')");
                    break;
                }
            case 'unactive':
                $sel->where("( service.dataunactive NOT NULL OR 
                    service.dataunactive < NOW() ) ");
                break;
        }

        return $this->fetchAll($sel);
    }
        
    public function getServicesByEquipment($idequipment, $state = 'active')
    {
        $sel = $this->select()->from($this->_name);
        $sel->setIntegrityCheck(false);
        $sel->joinInner(
                "equipment", 
                "equipment.idequipment = service.idequipment"
                );
        
        $sel->where("equipment.idequipment = " . (int) $idequipment);
        
        switch ($state) {
            case 'active': {
                    $sel->where("( dataunactive IS NULL OR 
                    dataunactive > NOW() OR 
                    dataunactive = '0000-00-00 00:00:00')");
                    break;
                }
            case 'unactive':
                $sel->where("( dataunactive NOT NULL OR dataunactive < NOW() ) ");
                break;
        }

        return $this->fetchAll($sel);
    }

    public function getInternet($idclient, $state = 'active')
    {
        $sel = $this->select();
        $sel->setIntegrityCheck(false);

        $sel->from("service");

        $sel->joinInner("equipment", 
        "equipment.idequipment = service.idequipment", array());

        $sel->where("idclient = " . (int) $idclient);
        $sel->where("tel is null OR tel <= 0 ");

        switch ($state) {
            case 'active': {
                    $sel->where("( dataunactive IS NULL OR 
                    dataunactive > NOW() OR 
                    dataunactive = '0000-00-00 00:00:00')");
                    break;
                }
            case 'unactive':
                $sel->where("( dataunactive NOT NULL OR dataunactive < NOW() ) ");
                break;
        }

        return $this->fetchAll($sel);
    }

    public function getPhone($idclient, $state = 'active')
    {
        $sel = $this->select();
        $sel->setIntegrityCheck(false);

        $sel->from("service");

        $sel->joinInner("equipment", "equipment.idequipment = service.idequipment", array());

        $sel->where("idclient = " . (int) $idclient);
        $sel->where("tel is not null AND tel > 0 ");

        switch ($state) {
            case 'active': {
                    $sel->where("( dataunactive IS NULL OR 
                    dataunactive > NOW() OR 
                    dataunactive = '0000-00-00 00:00:00')");
                    break;
                }
            case 'unactive':
                $sel->where("( dataunactive NOT NULL OR dataunactive < NOW() ) ");
                break;
        }

        return $this->fetchAll($sel);
    }

    public function saveData(array $Data, $dispatcher = null)
    {
        //$this->getAdapter()->beginTransaction();
        $ba = new Client_Service_BusinessAction();
        if ($dispatcher !== null) {
            $ba->setDispatcher($dispatcher);
        }
        
        foreach ($Data as $key => $service) {
            if (empty($service['idequipment']) ) {
                throw new Exception("I need an equipment to be assigned to 
                    the service {$service['idservice']}");
            }

            if ( empty($service['idpack'])) {
                throw new Exception("I need you to specify a pack");
            }

            if ($service['idservice'] > 0) {
                $Serv = $this->fetchRow("idservice = " . (int) $service['idservice']);
                if (null === $Serv)
                    throw new Zend_Exception("Service not found.");

                $Serv->setFromArray($service);
                
            } else {
                
                $Serv = $this->createRow($service);
                
                if ($this->hasService($Serv)) { 
                    // check if a service already exists with these details
                   throw new Exception("A service like this already exists for this client");
                }
            }

            try {
                $id = $Serv->save();
                
                try {

                    $ba->enableService($Serv);

//                    $this->getAdapter()->commit();
                } catch (Exception $e) {
//                    $this->getAdapter()->rollBack();
                    return false;
                }
                
            } catch ( Exception $e ) {
//                $this->getAdapter()->rollBack();
                throw new Exception($e->getMessage(), $e->getCode(), $e);
            }
            
        }
        
        return true;
    }
    
    public function hasService(Client_Model_Service $service )
    {
        if ($service->idequipment <= 0 ) {
            // bum
        }
        
        if ($service->tel > 0 ) {
            // check if phone number already in use
            if ($this->isNumberActive($service->tel, $service)) {
                throw new Exception("Phone number already active on a client.");
            }
        
            if ($this->lineInUse($service->idequipment, $service->linenumber)) {
                throw new Exception("Line in use for equipment " . $service->idequipment);
            }
        }
        
    }
    
    public function lineInUse($idequipment, $line)
    {
        $sel = $this->select();
        $sel->where("idequipment = ? ",$idequipment);
        $sel->where("linenumber = ? ", $line);
        $sel->where("dataunactive = '0000-00-00 00:00:00' ");
        $sel->orWhere("dataunactive IS NULL");
        
        $r = $this->fetchAll($sel);
        
        if ($r->count() > 0 ) {
            return true;
        } else {
            return false;
        }
    }
    
    public function isNumberActive($number, $service = null )
    {
        $sel = $this->select()->where("tel = ? ", $number);
        $sel->where("dataunactive = '0000-00-00 00:00:00' ");
        $sel->orWhere("dataunactive IS NULL");
        if ($service !== null ) {
            $sel->where("idequipment = ? ", $service->idequipment );
        }
        
        $r = $this->fetchAll($sel);
        
        if ($r === null ) {
            return false;
        }
        
        if ($r->count() > 0 ) {
            return true;
        }
        
        return false;
    }
    
    public function hasPack(DM_Model_Service $service)
    {
        $sel = $this->select()->where("idequipment = ? ", $service->idequipment);
        $sel->where("dataunactive = '0000-00-00 00:00:00' ");
        $sel->orWhere("dataunactive IS NULL");
        $sel->where("tel <= 0 ");
        
        $r = $this->fetchAll($sel);
        if ($r !== null ) {
            return false;
        }
        
        if ($r->count() > 0 ) {
            return true;
        }
        
        return false;
    }
    
}
