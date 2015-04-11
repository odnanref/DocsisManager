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
 * Description of ClienteController
 *
 * @author andref
 * @version $Id$
 */
class Client_ClientController extends Zend_Controller_Action
{

    private $Menus = array('clienteinfo' =>
        array('nome',
            'contrato', 'celula', 'estado'),
        'contacto' => array('telefone', 'telemovel', 'email'),
        'servico' => array()
    );

    /**
     * Form
     *
     * @var Zend_Form
     */
    protected $form;

    public function init()
    {
        Zend_Dojo::enableView($this->view);
    }

    public function indexAction()
    {
        $this->render("list");
    }

    public function listAction()
    {
        
    }
    
    public function getajaxAction()
    {
        $rhttp = new Zend_Controller_Request_Http();
        $estado = $rhttp->getQuery("state");

        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $cli    = new Client_Model_Clients();
        if ($estado === null || $estado == 'active') {
            $result = $cli->getActives();
        } else {
            $result = $cli->getActives();
        }

        $data = new Zend_Dojo_Data('idclient', $result->toArray());
        print $data->toJson();
    }
    
    public function newAction()
    {
        $id = (int) $this->_getParam("id", 0);
        
        if ($id <= 0 && array_key_exists("clienteinfo", $_POST) && 
                array_key_exists("idclient", $_POST['clienteinfo'])) {
            $id = (int) $_POST['clienteinfo']['idclient'];
        }

        $form = new Client_Form_tabClient(array('idclient' => $id));
        $form->setAction("/client/client/new/id/" . $id);

        //$form->loadClientDetails();
        
        $cli = new Client_Model_Clients();
        if ($id > 0 ) {
            $cliente = $cli->fetchRow(" idclient = " . (int) $id);
        }

        $clienteinfo = $form->getSubForm("clienteinfo");
        if (count($_POST) > 0 && $clienteinfo->isValid($_POST['clienteinfo'])) {
            if (!empty($_POST['clienteinfo']['idclient'])) {
                $cli = new Client_Model_Clients();
                $idclient = (int) $_POST['clienteinfo']['idclient'];
                $cliente = $cli->fetchRow(" idclient = " . (int) $idclient);
            } else {
                $cliente = new Client_Model_Client();
            }
            
            $Valores = $form->getValues();

            $cliente->setFromArray($Valores['clienteinfo']);
            
            $cliente->phone     = (int)$_POST['contacto']['phone'];
            $cliente->mobile    = (int)$_POST['contacto']['mobile'];
            $cliente->email     = addslashes($_POST['contacto']['email']);
                        
            $id = $cliente->save();
            if ($id > 0) {
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('failure'=>'Falha a guardar dados.')
                        );
            }

            $form->setDefaults($cliente->toArray());
            
        }
        
        if (isset($cliente) && is_object($cliente)) {
            $form->setDefaults($cliente->toArray());

            // Handle DEVICES
            $formDevices = $form->getSubForm("devices");
            if ($formDevices !== null) {
                $this->formDevices($formDevices, $cliente);
            }

            // Handle Servicos
            $formService = $form->getSubForm("serviceinternet");
            if ($formService !== null) {
                $this->formServices($formService, "internet", $cliente);
            }

            $formServiceTel = $form->getSubForm("servicephone");
            if ($formServiceTel !== null) {
                $this->formServices($formServiceTel, "phone", $cliente);
            }
        }

        $this->view->form = $form;
        
        $this->render("form", null, true);
    }

    public function searchAction()
    {
        $form = new Client_Form_Clientsearch();
        $form->setAction("/client/client/search/");
        
        $d = new Zend_Dojo_Data("idclient", array());
        $this->view->resultado = $d->toJson();
        
        if ( count($_POST) > 0 && $form->isValid($_POST['clientsearch']) ) {
            $cli = new Client_Model_Clients();
            $data = $cli->search($form->getValues(true) );
            
            $d = new Zend_Dojo_Data("idclient", $data->toArray());
            $this->view->resultado = $d->toJson();
        }
        
        $this->view->form = $form;
        $this->render("form", null, true);
        $this->render("list");
    }

    /**
     * Gerir equipamentos
     *
     * @param Zend_Form_SubForm $formDevices
     * @param Client_Model_Cliente $cliente
     * @return Zend_Form_SubForm
     */
    
    public function formDevices(Client_Form_Equipments $formDevices, Client_Model_Client $cliente)
    {
        $PDevs = array();

        if (array_key_exists("devices", $_POST)) {
            $formDevices->preValidate($_POST['devices']);
            $PDevs = $_POST['devices'];
        }

        if ($this->_request->isPost() && $formDevices->isValid($PDevs)) {

            $tmp = $formDevices->getValues();

            $eqs = new Client_Model_Equipment();
            // Really weird hack for zend_form
            foreach($_POST['devices'] as $key => $tmpDev) {
                if (array_key_exists("idmodel", $tmpDev)) {
                    $tmp['devices'][$key] = $tmpDev;
                }
                $tmp['devices'][$key]['idclient'] = (int) $cliente->idclient;
            }
            
            try {
                $eqs->saveData($tmp['devices']);
            } catch (Exception $e ) {
                print $e->getMessage(); // TODO handle has error in form
            }
            
            $formDevices->setDefaults($eqs->getDevices($cliente->idclient)->toArray());
        } else {
            
            if ($cliente->idclient > 0) {
                $devs = new Client_Model_Equipment();
                $devices = $devs->getDevices($cliente->idclient);
                $formDevices->setDefaults($devices->toArray());
            }
        }

        return $formDevices;
    }

    /**
     * Gerir servicos
     *
     * @param Zend_Form_SubForm $formService
     * @param string $type (phone, internet)
     * @param Client_Model_Cliente $cliente
     * @return Zend_Form_SubForm
     */
    
    public function formServices(Client_Form_Services $formService, $type,
            Client_Model_Client $cliente)
    {
        $servs = new Client_Model_Services();
        $type1 = "service".$type;
        if ($this->getRequest()->isPost() && array_key_exists($type1, $_POST)) {
            $formService->setIdcliente($cliente->idclient);
            $formService->preValidate($formService->getValues());

            if ($formService->isValid($_POST[$type1])) {
                $servs->saveData($_POST[$type1]);
            }
        }

        if ($type == 'phone') {
            $Services = $servs->getPhone($cliente->idclient);
        } else {
            $Services = $servs->getInternet($cliente->idclient);
        }
        
        $formService->setDefaults($Services->toArray());
        return $formService;
    }

    public function testAction()
    {
        $fm = new Client_Form_Equipments(array('idclient' => 34));
        $fm->addDecorator("Form");
        $fm->setAction("/client/client/test/");

        if ($fm->isValid($_POST)) {
            $eqs = new Client_Model_Equipment();
            foreach ($_POST['devices'] as $key => $dev) {
                $_POST['devices'][$key]['idclient'] = 34;
            }
            $eqs->saveData($_POST['devices']);
        }

        $this->view->form = $fm;

        $this->render("form", null, true);
    }

    public function test2Action()
    {
        $fm = new Client_Form_Services("phone", array("idclient" => 34));
        $fm->addDecorator("Form");
        $fm->setAction("/client/client/test2/");

        if ($fm->isValid($_POST)) {
            $servs = new Client_Model_Services();
            $servs->saveData($_POST['phone']);
        }

        $this->view->form = $fm;

        $this->render("form", null, true);
    }

}
