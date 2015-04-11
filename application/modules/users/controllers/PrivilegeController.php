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
 * manage PrivilegeController privileges
 *
 * @author andref
 * @version $Id$
 */
class Users_PrivilegeController extends Zend_Controller_Action
{
    private $columns = array(
        "idprivilege"    => "ID"
        ,"modulename"     => "Modulo"
        ,"controllername" => "Pagina"
        ,"controlleraction" => "Acção"
        ,"group"        => "Grupo"
        ,"r"    => "Ler"
        ,"w"    => "Editar"
        ,"d"    => "Apagar"
    );
    
    protected $id = "idprivilege";
    
    public function init()
    {
        parent::init();
        Zend_Dojo::enableView($this->view);
        
        $this->view->idfield = $this->id;
        $this->view->columns = $this->columns;
        $this->view->controller = "privilege";
    }

    public function getajaxAction()
    {
        $group = (int) $this->_getParam("idprivilege", -1);

        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $dm = new Users_Model_Privileges();
        if ($group > 0) {
            // filter by user
            $result = $dm->fetchAll("idprivilege = " . (int) $group);
        } else {
            $result = $dm->fetchAll();
        }

        $data = new Zend_Dojo_Data('idprivilege', $result->toArray());
        print $data->toJson();
    }

    public function indexAction()
    {
        $prv = new Users_Model_Privileges();
        $this->view->privs = $prv->fetchAll();
        
        $this->render("index", null, true);
    }
    
    public function vAction()
    {
        $id     = $this->_getParam("id");
        $grp    = new Users_Model_Groups();
        $pri    = new Users_Model_Privileges();
        
        $groups = array();
        foreach ($grp->fetchAll() as $group ) {
            $groups[$group->idacgroup] = $group->name;
        }
        
        $form = new Users_Form_Privilege(array("groups" => $groups));
        
        if ($id > 0 ) {
            $priv = $pri->fetchRow("idprivilege = " . (int) $id);
            if ($priv !== null)
                $form->populate($priv->toArray());
        }
        
        if ( count($_POST) > 0 && $form->isValid($_POST)) {
            if ($form->getValue("idprivilege") <= 0 ) {
                $priv = $pri->createRow($form->getValues());
            } else {
                $priv = $pri->fetchRow("idprivilege = " . (int) $form->getValue("idprivilege"));
                if ($priv !== null ) {
                    $priv->setFromArray($form->getValues());
                }
            }
            
            $id = $priv->save();
            if ($id <= 0 ) {
                $this->_helper->flashMessenger->addMessage(
                        array('failure'=>'Falha a guardar dados.')
                        );
            } else {
                $form->populate($priv->toArray());
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
            }
        }
        
        $this->view->form = $form;
        
        $this->render("form", null, true);
    }
}
