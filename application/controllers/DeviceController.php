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
 * Brand / Model Management interface control
 *
 * @author andref
 *
 */
class DeviceController extends Zend_Controller_Action
{

    public function init()
    {
        Zend_Dojo::enableView($this->view);
    }

    public function getmodelAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $rhttp = new Zend_Controller_Request_Http();
        $idbrand = $rhttp->getQuery("idbrand");

        $mo = new DM_Model_Model();
        $result = $mo->getForcombo($idbrand);

        $data = new Zend_Dojo_Data('idmodel', $result);
        echo $data->toJson();
    }

    public function addbrandAction()
    {
        $form = new DM_Form_Brand();
        $form->setAction("/device/addbrand/");

        if ($form->isValid($_POST)) {
            $vals = $form->getValues();

            $brand = new DM_Model_Brand();
            if (array_key_exists("idbrand", $vals) && $vals['idbrand'] > 0 ) {
                $brand->update($vals, "idbrand = ".(int) $vals['idbrand']);
                $id = (int)$vals['idbrand'];
            } else {
                $id = $brand->insert($vals);
            }

            if ($id > 0) {
                $this->_helper->flashMessenger->addMessage(
                        array('success' => 'Sucesso a guardar dados.')
                );
            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('error' => 'Falha a guardar dados.')
                );
            }

            $res = $brand->fetchRow("idbrand = ".(int) $id);
            if ($res) {
                $form->populate($res->toArray());
            }
        }

        $this->view->form = $form;
        $this->render("form", null, true);
    }

    public function addmodelAction()
    {
        $id = 0;
        $form   = new DM_Form_Model(array("brands" => new DM_Model_Brand()));
        $form->setAction("/device/addmodel/");

        if (count($_POST) > 0 && $form->isValid($_POST)) {
            $vals   = $form->getValues();
            $model  = new DM_Model_Model();
            if (array_key_exists("idmodel", $vals) && $vals['idmodel'] > 0 ) {
                $model->update($vals, "idmodel = " . (int ) $vals['idmodel']);
                $id = (int)$vals['idmodel'];
            } else {
                $id = $model->insert($vals);
                if ($id > 0) {
                    $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
                } else {
                    $this->_helper->flashMessenger->addMessage(
                        array('error'=>'Falha a guardar dados.')
                        );
                }
            }
        }

        if ($id > 0 ) {
            $res = $model->fetchRow("idmodel = " . (int) $id );
            if ($res) {
                $form->populate($res->toArray());
            }
        }

        $this->view->form = $form;
        $this->render("form", null, true);
    }

    public function vAction()
    {
        $id     = $this->_getParam("id", -1);
        $type   = $this->_getParam("type");

        if ($type == 'getmodels') {
            if ($id > 0) {
                $mod = new DM_Model_Model();
                $res = $mod->fetchAll("idmodel=" . (int) $id);
                $res = $res->getRow(0);
            }

            $form   = new DM_Form_Model(array("brands" => new DM_Model_Brand()));
            $form->setAction("/device/addmodel/");
            if ($res) {
                $form->populate($res->toArray());
            }

        } else {
            if ($id > 0) {
                $mod = new DM_Model_Brand();
                $res = $mod->fetchAll("idbrand=" . (int) $id);
                $res = $res->getRow(0);
            }
            $form   = new DM_Form_Brand();
            $form->setAction("/device/addbrand/");
            if ($res) {
                $form->populate($res->toArray());
            }
        }

        $this->view->form = $form;
        $this->render("form", null, true);
    }

    public function listbrandAction()
    {
        $this->view->type = "brand";
        $this->render("list");
    }

    public function listmodelAction()
    {
        $this->view->type = "model";
        $this->render("list");
    }

    public function getbrandsAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $dm = new DM_Model_Brand();
        $result = $dm->fetchAll();

        $data = new Zend_Dojo_Data('idbrand', $result->toArray());
        $data->setLabel("name");
        print $data->toJson();
    }

    /**
     * If specified an Id it will return models by
     * idbrand = $id
     *
     * @param int|null id
     *
     */
    public function getmodelsAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $id = $this->_getParam("id");
        $where = '';
        if ($id > 0 ) {
            $where = "model.idbrand = " . (int) $id;
        }
        $dm = new DM_Model_Model();
        $result = $dm->getAll($where);

        $data = new Zend_Dojo_Data('idmodel', $result->toArray());
        $data->setLabel("description");
        print $data->toJson();
    }

}
