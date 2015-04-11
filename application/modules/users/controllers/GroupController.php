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
 * GroupController manages groups
 *
 * @author andref
 * @version $Id$
 */
class Users_GroupController extends Zend_Controller_Action
{

    protected $columns = array(
        'idacgroup' => "ID",
        'name' => "Nome",
        'admin_id' => "Admin."
    );
    protected $id = "idacgroup";

    /**
     * Holds the json of the user list of a group
     * 
     * @var string
     */
    protected $userGroup = array();

    public function init()
    {
        parent::init();
        $this->view->headTitle("Gestão de Grupos :: ");
        $this->view->idfield = $this->id;
        $this->view->columns = $this->columns;
        $this->view->controller = "group"; // controller / action
    }

    public function getajaxAction()
    {
        $user = (int) $this->_getParam("iduser", -1);

        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $dm = new Users_Model_Groups();
        if ($user > 0) {
            // filter by user
            $result = $dm->getAllByUser($user);
        } else {
            $result = $dm->fetchAll();
        }

        $data = new Zend_Dojo_Data('idacgroup', $result->toArray());
        print $data->toJson();
    }

    public function indexAction()
    {
        $this->render("index", null, true);
    }

    public function vAction()
    {
        $id = (int) $this->_getParam("id", -1);

        $form = new \Users_Form_Group();
        $grp = new \Users_Model_Groups();

        if ($id > 0) {
            $Group = $grp->fetchRow("idacgroup = " . (int) $id);
            if ($Group !== null) {
                $form->setDefaults($Group->toArray());
            }
        }

        if (count($_POST) > 0 && $form->isValid($_POST)) {
            $vals = $form->getValues("group");
            if (($vals['idacgroup'] + 0) > 0) {
                $Group = $grp->fetchRow("idacgroup = " . (int) $vals['idacgroup']);
                $Group->setFromArray($vals);
                $Group->save();
                $id = $Group->save();
            } else {
                $Group = new \Users_Model_Group();
                $Group->setFromArray($vals);
                $id = $Group->save();
            }

            if ($id <= 0) {
                $this->_helper->flashMessenger->addMessage(
                        array('error'=>'Falha a guardar dados.')
                        );
            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
            }

            $form->setDefaults($Group->toArray());
        }

        $this->view->form = $form;
        $this->view->idacgroup = (int) $id;

        $this->render("vlayout");
    }

    public function loadusersgroupAction()
    {
        // Type query to get objects 
        $typeQ  = $this->_getParam("type", "ingroup");
        $id     = $this->_getParam("id", 0);

        $this->_helper->layout
                ->disableLayout();
        $this->getHelper('viewRenderer')
                ->setNoRender(true);

        $idArray = array();

        $grp_usr = new \Users_Model_UsersGroups();
        foreach ($grp_usr->fetchAll("idacgroup = " . (int) $id) as $userGrp) {
            $idArray[] = $userGrp->idacuser;
        }

        $us = new \Users_Model_Users();

        switch ($typeQ) {
            case 'notingroup';
                $userList = $us->getAllExcept($idArray);
                break;

            case 'ingroup': default:
                $list = implode(",", $idArray);

                $userList = $us->fetchAll("idacuser IN ($list)");
                break;
        }

        if ($userList !== null ) {
            $data = new Zend_Dojo_Data ("idacuser", $userList->toArray(), "login");
            print $data->toJson();
        }
        
    }

    public function joinAction()
    {
        $this->_helper->layout
                ->disableLayout();
        $this->getHelper('viewRenderer')
                ->setNoRender(true);

        $id = $this->_getParam("id", -1);
        $Unable = array();

        if (!array_key_exists("join", $_POST) || $id <= 0) {
            return $this->getResponse()
                            ->setHttpResponseCode(404)
                            ->setBody("Invalid post $id ");
        }

        $grp_usr = new \Users_Model_UsersGroups();
        foreach ($_POST['join'] as $user) {
            $b = $grp_usr->join($user, $id);
            if ($b === false) {
                $Unable[] = "Failed adding user $user to group $id ";
            }
        }

        $tmp = '';
        if (count($Unable) > 0) {
            foreach ($Unable as $err) {
                $tmp .= $err;
            }
        } else {
            $tmp = "All OK";
        }

        $this->getResponse()->setBody($tmp);
    }

    public function unjoinAction()
    {
        $this->_helper->layout
                ->disableLayout();
        $this->getHelper('viewRenderer')
                ->setNoRender(true);

        $id = $this->_getParam("id", -1);
        $Unable = array();

        if (!array_key_exists("join", $_POST) || $id <= 0) {
            return $this->getResponse()
                            ->setHttpResponseCode(404)
                            ->setBody("Invalid post $id ");
        }

        $grp_usr = new \Users_Model_UsersGroups();
        foreach ($_POST['join'] as $user) {
            $b = $grp_usr->unjoin($user, $id);
            if ($b === false) {
                $Unable[] = "Failed removing user $user from group $id ";
            }
        }

        $tmp = '';
        if (count($Unable) > 0) {
            foreach ($Unable as $err) {
                $tmp .= $err;
            }
        } else {
            $tmp = "All OK";
        }

        $this->getResponse()->setBody($tmp);
    }

}