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
 * Description of Equipment
 * 
 * manage equipaments from client physical and non physical
 *
 * @author andref
 * @version $Id$
 */
class Client_Model_Equipment extends Zend_Db_Table_Abstract
{

    protected $_name        = "equipment";

    protected $_primary     = "idequipment";

    protected $_rowClass    = "Client_Model_Device";

    protected $_sequence    = true;

    protected $dependentTables = array("service");

    protected $_referenceMap = array(
        "typeequipment" => array(
            "columns" => "idtypeequipment",
            "refTableClass" => "Client_Model_Typeequipment",
            "refColumns" => "idtypeequipment"
        ),
        "model" => array(
            "columns" => "idmodel",
            "refTableClass" => "DM_Model_Model",
            "refColumns" => "idmodel"
        )
    );
        
    /**
     * Dispatch events
     * 
     * @var Symfony\Component\EventDispatcher\EventDispatcher
     */
    private $_dispatcher = null;
    /**
     * set dispatcher
     * 
     * @param Symfony\Component\EventDispatcher\EventDispatcher $disp 
     * @return Client_Model_Equipment
     */
    public function setDispatcher(Symfony\Component\EventDispatcher\EventDispatcher $disp)
    {
        $this->_dispatcher = $disp;
        return $this;
    }
    /**
     * get Dispatcher for events
     * 
     * @return Symfony\Component\EventDispatcher\EventDispatcher
     */
    public function getDispatcher()
    {
        return $this->_dispatcher;
    }

    /**
     * Search for active equipment
     *
     * @param array $Info
     * @param int $notInClient if filled this will be used has exception
     *
     * @return Zend_Db_Table_Rowset
     */
    public function getActivo(array $Info, $notInClient = false)
    {
        $sel = $this->select();
        foreach ($Info as $campo => $valor) {
            if (!empty($valor) || ( is_numeric($valor) && $valor == 0)) {
                $sel->where(" $campo = ? ", array($valor));
            }
        }

        $sel->where("(dataout IS NULL OR dataout > NOW() OR dataout = '0000-00-00 00:00:00' ) ");

        if ($notInClient > 0) {
            $sel->where(" idclient != ? ", $notInClient);
        }

        return $this->fetchAll($sel);
    }

    public function getDevices($idclient, $state = 'active')
    {
        $sel = $this->select()->where("idclient = " . (int) $idclient);
        switch ($state) {
            case 'active': {
                    $sel->where("( dataout IS NULL OR dataout > NOW() OR dataout = '0000-00-00 00:00:00' ) ");
                }
                break;
            case 'unactive':
                $sel->where("( dataout NOT NULL OR dataout < NOW() OR dataout = '0000-00-00 00:00:00' ) ");
                break;
            case 'all':
                break;
        }

        return $this->fetchAll($sel);
    }
    /**
     * get all by client
     * 
     * @param int $idclient
     * @return Zend_Db_Table_Rowset
     */
    public function getAllByIdclient($idclient)
    {
        if ($idclient <= 0 ) {
            throw new Exception("ID not valid.");
        }
        $sel = $this->select()->from($this->_name);
        $sel->setIntegrityCheck(false);
        $sel->joinInner("typeequipment", 
                "typeequipment.idtypeequipment = " . $this->_name . ".idtypeequipment ", 
                "name as type");
        $sel->joinInner("model", "model.idmodel = equipment.idmodel", "");
        $sel->joinInner("brand", "brand.idbrand = model.idbrand", 
                new Zend_Db_Expr("CONCAT(brand.name, ' ', model.description) as full_model_description")
                );
        $sel->where("equipment.idclient = ? ", (int) $idclient);
        
        return $this->fetchAll($sel);
    }
    
    public function getByMacaddr($mac)
    {
        $sel = $this->select()->where("macaddr = ? ", $mac);
        return $this->fetchAll($sel);
    }

    public function getEquipmentsToCombo($idclient)
    {
        $Equipamentos = array(0 => '');
        foreach (
                $this->fetchAll("idclient = " . (int) $idclient .
                " AND (dataout IS NULL OR dataout = '0000-00-00 00:00:00' )"
                ) 
                as $dev)
        {
            $te = $dev->findParentRow("Client_Model_Typeequipment", 'typeequipment');
            $Equipamentos[$dev->idequipment] = $te->name . " " .
                    $dev->serialnum . " " . $dev->macaddr;
        }
        
        return $Equipamentos;
    }
    
    /**
     * Remover o cancel
     *
     * @param int $id
     * @param datetime $data
     * @return int
     */
    public function cancel($id, $data = null)
    {
        if ($data === null || $data == "0000-00-00 00:00:00") {
            $data = date("Y-m-d H:i:s");
        }
        
        return $this->update(array("dataout" => $data), "idequipment = " . (int) $id);
    }

    public function saveData(array $Data, $idclient = 0)
    {        
        $this->getAdapter()->beginTransaction();
        
        $devs   = null;
        $saveit = false;
        
        foreach ($Data as $device) {
            $id = 0;
            unset($dev);
            
            if (empty($device['idtypeequipment'])) {
                throw new Zend_Exception("Sem tipo de equipamento");
            }

            if (empty($device['serialnum'])) {
                throw new Zend_Exception("Sem numero de serie");
            }

            if ($device['idequipment'] > 0) {
                $dev = $this->fetchRow("idequipment =" . 
                        (int) $device['idequipment']);
            }

            if (array_key_exists("idclient", $device) && $device['idclient'] > 0 ) {
                $idclient = $device['idclient'];
            }
            
            $Activo = $this->getActivo(array(
                'macaddr' => $device["macaddr"]
                , 'serialnum' => $device["serialnum"]
                , 'idtypeequipment' => $device["idtypeequipment"]
                )
                , (int) $idclient
            );

            if ($Activo->count() > 0) {
                throw new Zend_Exception("Este equipamento (" . $device['serialnum'] . ") está associado a um outro cliente e activo.");
            }
                        
            if (!isset($dev)) {
                $dev = $this->createRow($device);                
            } else {
                $dev->setFromArray($device);
            }
            $dev->idclient = $idclient;

            $id = $dev->save();
            
            if ($id == $device['idequipment'] && $id > 0 ) {
                $typeDispatch = "update";
            } else if ($id > 0 && $id != $device['idequipment'] ) {
                $typeDispatch = "insert";
            }
            
            if ($id > 0) {
                $devs[] = $dev;
            } else {
                $this->getAdapter()->rollBack();
                throw new Zend_Exception(
                        "Error saving equipment ( " . $device['serialnum'] . 
                        " ) $id "
                        );
            }
            
            $this->getDispatcher()->dispatch(
                    "client.equipment.$typeDispatch", 
                    new Client_Service_EquipmentEvent(array('device' => $dev))
                    );
        }
        
        $this->getAdapter()->commit();
        
        return $devs;
    }
    
}
