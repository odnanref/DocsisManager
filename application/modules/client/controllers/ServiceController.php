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
 * Description of ServiceController
 *
 * @author andref
 * @version $Id$
 */
class Client_ServiceController extends Zend_Controller_Action
{
    private $_dispatcher;
    
    public function init()
    {
        $bootstrap = $this->getInvokeArg('bootstrap');
        $this->_dispatcher = $bootstrap->getResource('Far_Resource_EventDispatcher');
    }
    
    public function vAction()
    {        
        $idclient  = $this->_getParam("idclient", 0);
        if ($idclient <= 0 ) {
            // Handle no client
            $this->_setParam("missingmessage", "No client was set.");
            $this->_forward("missingdata", "error");
        }
        
        $type = $this->_getParam("type", null);
        if ($type === null || !in_array($type, Client_Form_Services::$Availabletypes ) ) {
            $this->_setParam("missingmessage", 
                    "Sem tipo de serviço indicado ou servi&ccedil;o n&atilde;o reconhecido $type."
                    );
            $this->_forward("missingdata", "error");
        }
        
        $id = $this->_getParam("id", 0 );
        
        $sv         = new Client_Model_Services();
        $eqs        = new Client_Model_Equipment();
        
        $services   = $sv->getServices($idclient, 'active', $type);
        $equipments = $eqs->getEquipmentsToCombo($idclient);
        
        if (array_key_exists("internet", $_POST)) {
            $nrows      = count($_POST['internet']);
        } else {
            $nrows      = 0;
        }
        
        $form = new Client_Form_Services($type, 
                array ('services' => $services
                        ,'equipments' => $equipments
                        ,'idclient'  => $idclient
                    )
                );
        
        if (count($_POST) > 0 && $form->isValid($_POST) ) {
            
            $b = false;
            
            try {
                $b = $sv->saveData($values, $this->_dispatcher);
            } catch (Exception $e ) {
                $this->_helper->flashMessenger->addMessage(
                            array('Failure'=>$e->getMessage())
                            );
            }            
            
            if ($b === true) {
                // ALL OK
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );    
            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('failure'=>'Falha a guardar dados.')
                        );
            }
        }
        $services   = $sv->getServices($idclient, 'active', $type);
        $form->setDefaults($services->toArray());
        $this->view->form = $form;
        
        $this->render("form", null, true);
    }
    
    public function getservicesAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);
        
        $idclient = $this->_getParam("idclient", 0);
        $serv = new Client_Model_Services();
        $res = $serv->getServices($idclient);
        
        $data = new Zend_Dojo_Data("idservice", $res->toArray());
        print $data->toJson();
    }
    
    public function manageAction()
    {
        $idclient = $this->_getParam("idclient", 0);
        
        $this->view->idclient = $idclient;
        
    }
    
    /**
     * Remove the service
     *
     */
    public function removeAction()
    {
        $this->_helper->layout->disableLayout();
        //Zend_Dojo::enableView($this->view);
        $this->_helper->viewRenderer->setNoRender(true);
        
        $this->_helper->contextSwitch()->initContext('json');

        $id             = $this->_getParam("id", -1);
        $rawBody        = $this->_request->getRawBody();
        if (!$rawBody) {
            return;
        }

        $data = Zend_Json::decode($rawBody);

        if ($id <= 0 ) {
            $this->_response->setHttpResponseCode(404)
                            ->appendBody(Zend_Json_Encoder::encode("requested action unavailable"));
        }

        if (array_key_exists("dataunactive", $data)) {
            $data = $data['dataunactive'];
        } else {
            $data = null;
        }

        $ba     = new Client_Service_BusinessAction();
        $res    = $ba->disableService($id, $data);
        
        if ($res > 0 ) {
            $this->_response
                 ->setHttpResponseCode(201)
                 ->appendBody(Zend_Json_Encoder::encode("Canceled " . $res . " records"));
        } else {
            $this->_response
                 ->setHttpResponseCode(404)
                 ->appendBody(
                         Zend_Json_Encoder::encode("Unable to delete record idservice = ".$id . " $res ")
                         );
        }

    }
}
