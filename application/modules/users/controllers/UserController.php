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
 * Manage users, login , logout actions
 *
 * @author andref
 * @version $Id$
 */
class Users_UserController extends Zend_Controller_Action
{

    public function init()
    {
        Zend_Dojo::enableView($this->view);
    }

    public function indexAction()
    {
        $users = new Users_Model_Users();
        $this->view->users = $users->fetchAll();
    }

    public function getallAction()
    {
        $users = new Users_Model_Users();

        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);
        $result = $users->fetchAll();

        $data = new Zend_Dojo_Data('idacuser', $result->toArray());
        print $data->toJson();
    }
    /**
     * @deprecated
     */
    public function verAction()
    {
        $id = (int) $this->_getParam("idacuser");
        if ($id === null) {
            $id = $_POST['userinfo']['idacuser'];
        }
        $form = new \Users_Form_User();
        $form->setAction("/utilizador/ver/");

        $us = new Users_Model_Users();
        $User = $us->getById($id);

        if ($form->isValid($_POST)) {
            $User->idacuser = $_POST['userinfo']['idacuser'];
            if (!empty($_POST['userinfo']['senha']) &&
                    ($_POST['userinfo']['senha'] == $_POST['userinfo']['senha2'])
                    ) {
                $User->senha = $_POST['userinfo']['senha'];
            }
            $User->email = $_POST['userinfo']['email'];
            $User->nome = $_POST['userinfo']['nome'];
            $User->estado = $_POST['userinfo']['estado'];
            $id = $User->save();
            if ($id <= 0 ) {
                $this->_helper->flashMessenger->addMessage(
                        array('error'=>'Falha a guardar dados.')
                        );
            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
            }
        } else {
            $User->senha = "";
        }

        if ($User !== null ) {
            $form->setDefaults($User->toArray());
        }

        $this->view->form = $form;
        $this->render("form", null, true);
    }

    public function logoutAction()
    {
        Users_Plugin_Auth::getInstance()->clearIdentity();
        // unset cookies
        if (isset($_SERVER['HTTP_COOKIE'])) {
            $cookies = explode(';', $_SERVER['HTTP_COOKIE']);
            foreach ($cookies as $cookie) {
                $parts = explode('=', $cookie);
                $name = trim($parts[0]);
                setcookie($name, '', time() - 1000);
                setcookie($name, '', time() - 1000, '/');
            }
        }
        return $this->_redirect("/users/user/login/");
    }

    /**
     * Login action
     *
     * @return void
     */
    public function loginAction()
    {
        // Get our form and validate it
        $form = new Users_Form_Login();
        $form->setAction("/users/user/login/");

        $valid = false;

        try {
            if (count($_POST) > 0 && $form->isValid($_POST)) {
                $valid = $this->getAuthAdapter($form->getValues());
            }
        } catch(Far_Access_Exception_AccessDenied $e ) {
            $this->_helper->flashMessenger->addMessage(
                        array('error'=>$e->getMessage())
                        );
        }

        if (!$form->isValid($_POST) || !$valid) {
            $form->setDescription('Introduza os dados de acesso.');
            // Invalid entries
            $this->view->form = $form;
            return $this->render('form', null, true);
            //// re-render the login form
        }

        // We're authenticated! Redirect to the home page
        $this->_redirect("/");
    }

    public function getAuthAdapter(array $params)
    {
        $auth = Users_Plugin_Auth::getInstance();
        $auth->setLogin($params['username']);
        $auth->setPass($params['password']);
        $res = $auth->authenticate();
        return $res;
    }

    public function addAction()
    {
        $id = (int) $this->_getParam("id", -1);

        $tmp = "id/" . $id;
        $users = new \Users_Model_Users();
        $form = new \Users_Form_User();
        $form->setAction("/users/user/add/");

        if ($id < 0 ) {
            if ($form->isValid($_POST)) {
                $vals   = $form->getValues("userinfo");
            }
        }

        if ($id > 0 ) {
            $user = $users->fetchRow("idacuser = " . (int) $id );
            if ($user !== null ) {
                $user->senha = "";
                $form->setDefaults($user->toArray());
            }
            $form->setAction($form->getAction().$tmp);
        }

        if ( count($_POST) > 0 && $form->isValid($_POST)) {
            $vals = $form->getValues("userinfo");

            $users = new \Users_Model_Users();

            if ((int)$id > 0 ) {
                $user = $users->fetchRow("idacuser = " . (int) $id );
                if ($user !== null ) {
                    $user->setFromArray($vals);
                }
            } else {
                $user = $users->createRow($vals);
                if ($users->hasLogin($vals["login"], $id)) {

                    $this->_helper->flashMessenger->addMessage(
                        array('error'=>"Falha a guardar. Login já existe.")
                        );

                    $this->_redirect("/users/user/add/");
                }
            }

            if ( !empty($vals["senha"]) &&
                    $vals["senha"] == $_POST['userinfo']["senha2"]) {
                $user->senha = $vals["senha"];
            }

            $id = $user->save();

            if ($id > 0 ) {
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>"Guardado com sucesso.")
                        );

                $this->_redirect("users/user/add/id/". (int) $id);

            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('error'=>"Falha a guardar.")
                        );
            }
        }

        $this->view->idacuser   = (int)$id;
        $this->view->form       = $form;

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
        foreach ($grp_usr->fetchAll("idacuser = " . (int) $id) as $userGrp) {
            $idArray[] = $userGrp->idacgroup;
        }

        $us = new \Users_Model_Groups();

        switch ($typeQ) {
            case 'notingroup';
                $userList = $us->getAllExcept($idArray);
                break;

            case 'ingroup': default:
                $list = implode(",", $idArray);

                $userList = $us->fetchAll("idacgroup IN ($list)");
                break;
        }

        if ($userList !== null ) {
            $data = new Zend_Dojo_Data ("idacgroup", $userList->toArray(), "name");
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
            $b = $grp_usr->join($id, $user);
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
            $b = $grp_usr->unjoin($id, $user);
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
