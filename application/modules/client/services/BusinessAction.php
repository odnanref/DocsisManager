<?php

/*

  Copyright (C) 2010 Fernando Ribeiro < netriver at gmail dot com >

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

/**
 * Description of BusinessAction
 * 
 * Executes logic market operations acording to actions on 
 * equipments and services of a client
 *
 * @author andref
 * @version $id$
 * 
 */
class Client_Service_BusinessAction {
    /**
     * Equipment Model
     * 
     * @var DM_Model_Equipment
     */
    protected $eq;
    /**
     *
     * @var DM_Model_Service
     */
    protected $sv;
    /**
     *
     * @var DM_Model_Client
     */
    protected $Clt;
    
    public function __construct() 
    {
        $this->eq = new Client_Model_Equipment();
        $this->sv = new Client_Model_Services();
        $this->Clt = new Client_Model_Clients();
    }
    /**
     * Event dispatcher
     * 
     * @var \Symfony\Component\EventDispatcher\EventDispatcher
     */
    protected $_dispatcher = null;
    
    public function setDispatcher($disp)
    {   
        $this->_dispatcher = $disp;
    }
    
    public function disableEquipment($id, $data = null )
    {
        $eqs = $this->sv->fetchAll(" idequipment = " . (int)$id .
        " AND ( dataunactive IS NULL OR dataunactive = '0000-00-00 00:00:00' ) ");
        if ( $eqs !== null ) {
            foreach ($eqs as $eq ) {
                $this->disableService($eq, $data);
            }
        }
        
        $nrows = $this->eq->cancel($id, $data);
        if ($nrows < 0 ) {
            return 0; // Leave here avoid dispatching the event
        }
        
        $this->_dispatcher->dispatch(
                    "equipment.disable", 
                    new Client_Service_EquipmentEvent(
                            array('list' => 
                                array(
                                    $this->eq->fetchRow("idequipment = " . 
                                            (int) $id)
                                    )
                                )
                            )
                    );
        
        return $nrows;
    }
    
    public function disableService($id, $data = null)
    {
        if (is_numeric($id)) {
            $row = $this->sv->fetchAll("idservice = " . (int) $id);
            if ($row === null ) {
                throw new OutOfBoundsException("Service not found with id $id");
            }
            $row = $row->getRow(0);
        } else {
            $row = $id;
            $id = $row->idservice;
        }
                
        $dms = new DM_Model_Docsismodems();
        
        $eq = $this->eq->fetchRow("idequipment = " . (int)$row->idequipment );

        if ($eq !== null ) {
            $dm = $dms->fetchRow("macaddr = '".$eq->macaddr."'");
            if ($dm === null ) {
                throw new Exception(
                        "Unable to find cm with macaddr:". 
                        $eq->macaddr . " , " . $eq->idequipment
                        );
            }
            $dm->disable();
        }

        return $this->sv->cancel($id, $data);
    }
    
    public function disableClient($id, $data = null)
    {       
        foreach ( $this->Clt->fetchAll("idclient = " . (int) $id) as $clt ) {
            foreach ( $clt->findDependentRowset("equipment") as $eq ) {
                $this->disableEquipment($eq->idequipment, $data);
            }
        }
        
        $clt->cancel();
    }

    public function enableService($id, $data = null)
    {
        if (is_object($id) && ($id instanceof Client_Model_Service)) {
            $Service = $id;
        } else {
            $Service = $this->sv->fetchRow("idservice = " . (int) $id );
        }
        
        if ($Service === null )
            throw new Exception ("Service not found id:$id");
        
        $modem = $Service->findParentRow("Client_Model_Equipment");
        if ($modem === null )
            throw new Exception ("UNABLE TO FIND PARENT ");
        
        $idclient = (int) $modem->idclient;
        $filename = $idclient."_".$Service->idequipment;
        
        $type = $modem->findParentRow("Client_Model_Typeequipment");
        if ($type !== null && $type->code !== 'MODEM') {
            return null;
        }

        $model = $modem->findParentRow("DM_Model_Model");
        if ($model === null ) {
            throw new Exception("DID NOT FIND MODEL for " . $modem->idequipment);
        }
        $brand = $model->findParentRow("DM_Model_Brand");
        
        $pack = $Service->findParentRow("Client_Model_Pack");
        if ($pack === null )
            throw new Exception ("Failed to identify pack of service");

        $onefilemta = (bool) $brand->onefilemta;;

        $hasnet     = $this->clientHasNet($idclient, $Service->idequipment);
        $hasphone   = $this->clientHasPhone($idclient, $Service->idequipment);

        $CM_Config = $Service->getNetworkSpeed();
        
        if ($CM_Config !== false ) {
            $pack->downloadspeed    = $CM_Config['down'];
            $pack->uploadspeed      = $CM_Config['up'];
            $pack->prebuilt_file    = $CM_Config['prebuilt'];
            $pack->prebuilt_file_mta    = $CM_Config['prebuilt_mta'];
        }
        
        $ev = new Client_Service_ServiceEvent();
        $ev->setPack($pack);
        $ev->setOneFileMta($onefilemta);
        $ev->setHasPhone($hasphone);
        $ev->setHasNet($hasnet);
        $ev->setModem($modem);
        
        $this->_dispatcher->dispatch("service.alter", $ev);
        
    }
    
    public function clientHasPhone($idclient, $idequipment = null)
    {
        $idclient = (int)$idclient;
        foreach ($this->sv->getServices($idclient) as $serv ) {
            if ($idequipment > 0 && $serv->idequipment != $idequipment) 
                continue;
            
            if ( !empty($serv->tel) ) {
                return true;
            }
        }
        return false;
    }
    
    public function clientHasNet($idclient, $idequipment = null )
    {
        $idclient = (int)$idclient;
        foreach ($this->sv->getServices($idclient) as $serv ) {
            if ($idequipment > 0 && $serv->idequipment != $idequipment) 
                continue;
                
            if ( empty($serv->tel) ) {
                return true;
            }
        }
        return false;
    }
}
