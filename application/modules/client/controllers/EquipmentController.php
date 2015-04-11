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
 * Description of EquipmentController
 *
 * @author andref
 * @version $Id$
 */
class Client_EquipmentController extends Zend_Controller_Action
{

    /**
     * Event dispatcher
     * 
     * @var \Symfony\Component\EventDispatcher\EventDis patcher
     */
    protected $_dispatcher = null;
    
    public function init()
    {
        $bootstrap = $this->getInvokeArg('bootstrap');
        $this->_dispatcher = $bootstrap->getResource('Far_Resource_EventDispatcher');
    }
    
    public function indexAction()
    {
        $this->render("emptyfile", null, true);
    }
    
    public function newAction()
    {
        $this->_forward("v", null, null, $this->_getAllParams());
    }

    public function manageAction()
    {
        $id = $this->_getParam("idclient", -1);
        $this->view->idclient = (int)$id;
    }
    
    public function vAction()
    {        
        $id = $this->_getParam("id", 0);
        $idclient = $this->_getParam("idclient", 0);

        $eq = new Client_Model_Equipment();
        
        $options = array();
        
        if ($id > 0 ) {
            $equipment = $eq->fetchRow("idequipment = " . (int) $id);
        } else {
            $equipment = $eq->createRow();
        }

        $teq = new Client_Model_Typeequipment();
        $types = array(0 => '');
        foreach ($teq->fetchAll() as $tps) {
            $types[$tps->idtypeequipment] = $tps->name;
        }
        
        $options['typeequipments'] = $types;
        if ($idclient > 0 ) {
            $options['idclient'] = $idclient;
        }
        
        $form = new Client_Form_Equipments($options);
        
        if ($equipment->idequipment > 0) {
            $form->setDefaults($equipment->toArray());
        }
        
        if ($equipment->idclient > 0 || $idclient > 0) {
            $this->view->back_href = '/client/equipment/manage/idclient/' .
                   ( ($equipment->idclient > 0 ) ? $equipment->idclient : $idclient );
        }


        if (count($_POST) > 0 && $form->isValid($_POST)) {
            
            $eq->setDispatcher($this->_dispatcher);
            
            $vals = $form->getValues(true);
            try {
                $devs = $eq->saveData($vals);
                
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
            } catch (Zend_Exception $e ) {
                $this->_helper->flashMessenger->addMessage(
                        array('failure'=> $e->getMessage())
                        );
            }
            
            $equipment = $eq->fetchRow("idequipment = " . (int) $id);
        }
        
        if ($equipment !== null  && $equipment->idequipment > 0 ) {
            $form->setDefaults($equipment->toArray());
        }
        
        $this->view->form = $form;
        $this->render("form", null, true);
    }

    public function removeAction()
    {
        $this->_helper->layout->disableLayout();
        //Zend_Dojo::enableView($this->view);
        $this->_helper->viewRenderer->setNoRender(true);
        
        $this->_helper->contextSwitch()->initContext('json');

        $id = $this->_getParam("id", -1);
        $rawBody = $this->_request->getRawBody();
        if (!$rawBody) {
            return;
        }

        $data = Zend_Json::decode($rawBody);

        if ($id <= 0) {
            $this->_response->setHttpResponseCode(404)
                    ->appendBody(
                        Zend_Json_Encoder::encode("requested action unavailable")
                    );
        }

        if (array_key_exists("dataout", $data)) {
            $data = $data['dataout'];
        } else {
            $data = null;
        }

        $eq = new Client_Service_BusinessAction();
        $eq->setDispatcher($this->_dispatcher);
        
        $res = $eq->disableEquipment($id, $data);
        
        if ($res > 0) {
            $Eq = new Client_Model_Equipment();
                        
            $this->_response
                    ->setHttpResponseCode(201)
                    ->appendBody(Zend_Json_Encoder::encode("Canceled " . 
                            $res . " records")
                            );
        } else {
            $this->_response
                    ->setHttpResponseCode(404)
                    ->appendBody(
                            Zend_Json_Encoder::encode(
                                    "Unable to delete record idequipment = " . 
                                    $id . " $res "
                                    )
                                );
        }
    }
    
    public function gettypeAction()
    {
        $this->_helper->layout->disableLayout();
        //Zend_Dojo::enableView($this->view);
        $this->_helper->viewRenderer->setNoRender(true);
        
        $this->_helper->contextSwitch()->initContext('json');
        
        $where = '';
        
        $id = $this->_getParam("id", -1);
        
        if ($id < 0 ) {
            $where = "";
        } elseif ($id == 0 ) {
            return null;
        } else {
            $where = " idtypeequipment = " . (int) $id;
        }
        
        $teq = new Client_Model_Typeequipment();
        
        $r = $teq->fetchAll($where);
        $this->_response
             ->setHttpResponseCode(201)
             ->appendBody(
                     Zend_Json_Encoder::encode($r->toArray())
                     );
    }

    public function getbymacAction()
    {
        $this->_helper->layout->disableLayout();
        //Zend_Dojo::enableView($this->view);
        $this->_helper->viewRenderer->setNoRender(true);
        
        $this->_helper->contextSwitch()->initContext('json');
        $id = $this->_getParam("id");
        if ($id === null ) {
            return null;
        }
        
        $eq = new Client_Model_Equipment();
        $res = $eq->getByMacaddr($id);
        $this->_response
             ->setHttpResponseCode(201)
             ->appendBody(
                     Zend_Json_Encoder::encode($res->toArray())
                     );
        
    }
    
    public function getajaxAction()
    {
        $this->_helper->layout->disableLayout();
        //Zend_Dojo::enableView($this->view);
        $this->_helper->viewRenderer->setNoRender(true);
        
        $id = $this->_getParam("idclient", -1);
        
        if ($id <= 0 ) {
            return false;
        }
        
        $eqs = new Client_Model_Equipment();
        $res = $eqs->getAllByIdclient($id);
        if ($res !== null ) {
            $data = new Zend_Dojo_Data("idequipment", $res->toArray());
            $data->setMetadata("totalCount", $res->count());
            print $data->toJson();
        }
        
    }
    
}
