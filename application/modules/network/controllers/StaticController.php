<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Manage access for static ipaddr
 *
 * @author andref
 */
class Network_StaticController extends Zend_Controller_Action
{
    public function init()
    {
        Zend_Dojo::enableView($this->view);
    }
    
    public function getajaxAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $dm = new Network_Model_StaticNet();
        $result = $dm->GetAllDetails();
        if ($result !== null ) {
            $data = new Zend_Dojo_Data('ipaddr', $result->toArray());
            print $data->toJson();
        }
    }

    public function addAction()
    {
        $id = $this->_getParam("id", -1);
        
        $nets   = new Network_Model_Networks();
        $snet   = new Network_Model_StaticNet();
        
        $ipcalc = new \Bzeiss\IpCalc();
        $form   = new Network_Form_StaticNet(["networks" => $nets->fetchAll()]);
                
        if (count($_POST) > 0 && $form->isValid($_POST) ) {
            $Dados = $form->getValues();
            $subnum = $Dados['subnum'];
            $net = $nets->fetchRow("subnum = " . (int) $subnum);
            
            if (!$ipcalc->isIPInSubnet($ip)) {
                $this->_helper->flashMessenger->addMessage(
                        array('failure'=>'IP não está na subnet correcta.')
                        );
            }
            
            if ( $id > 0 && $ipcalc->isIp($ip)) {
                //$snet-> FIXME missing
//                if (strpos($net->network, "/") !== false ) {
//                    $nettmp = explode("/", $net->network);                    
//                    $mask = $nettmp[1];
//                    $maskBinStr = str_repeat("1", $mask ) . 
//                            str_repeat("0", 32-$mask );      //net mask binary string
//                    $ipMaskLong = bindec( $maskBinStr );
//                    
//                    $ipcalc->setNetworkAddress($nettmp[0]);
//                    $ipcalc->setSubnetmask($ipMaskLong);
//                    $ipcalc->isIPInSubnet($ip);
//                } else {
//                    $this->_helper->flashMessenger->addMessage(
//                        array('failure'=>'Não foi possível fazer parse à subnet.')
//                        );
//                }
                $netAddress = $ipcalc->calculateNetworkAddress($id, "255.255.255.254");
                if (!$netAddress) {
                    $this->_helper->flashMessenger->addMessage(
                        array('failure'=>'Não foi possível definir a rede.')
                        );
                }
                
                $nets->fetchAll(" substr(network, 1, locate("/", network)-1) = '$netAddress' ");
            }
            
            $static = $snet->createRow($Dados);
            $id = $static->save();
            if ($id > 0 ) {
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('failure'=>'Erro a guardar dados.')
                        );
            }
        }

        $this->view->form = $form;
        $this->render("form");
    }
    
    public function listAction()
    {
        
    }
}
