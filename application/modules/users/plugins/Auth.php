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
 * Plugin for Auth takes extends Zend_Auth
 * 
 * @author andref 
 * @version $Id$
 */
class Users_Plugin_Auth extends Zend_Auth
{
    /**
     * Adapter auth
     *
     * @var Zend_Auth_Adapter_DbTable
     */
    protected $_adapter;

    public function getauthAdapter()
    {
        return $this->_adapter;
    }

    /**
     * Utilizador devolvido da bd
     *
     * @var Far_Access_User
     */
    protected $_user;
    
    private static $_instancefar;

    /**
     * (non-PHPdoc)
     * @see Zend_Auth::getInstance()
     * @return Far_Auth
     */
    public static function getInstance()
    {
        if (null === self::$_instancefar) {
            self::$_instancefar = new self();
        }

        return self::$_instancefar;
    }

    /**
     *
     * @return Users_Plugin__Auth
     */
    public function __construct()
    {
        $authAdapter = new Zend_Auth_Adapter_DbTable(
                Zend_Db_Table::getDefaultAdapter()
                );

        $authAdapter
                ->setTableName('acusers')
                ->setIdentityColumn('login')
                ->setCredentialColumn('senha')
        ;

        $this->setAdapter($authAdapter);
    }

    private $login;

    /**
     *
     * @param string $login
     *
     */
    public function setLogin($login)
    {
        $this->login = $login;
        return $this;
    }

    public function getLogin()
    {
        return $this->login;
    }

    private $pass;

    public function setPass($pass)
    {
        $this->pass = $pass;
        return $this;
    }

    public function getPass()
    {
        return $this->pass;
    }

    /**
     * (non-PHPdoc)
     * @see Zend_Auth::authenticate()
     *
     * @return boolean
     */
    public function authenticate(Zend_Auth_Adapter_Interface $adapter = null)
    {
        $login = $this->getLogin();
        $pass = $this->getPass();

        if (empty($pass) || empty($login)) {
            return false;
        }

        $adapter    = $this->getauthAdapter();
        $adapter->setCredential($pass)
                ->setIdentity($login)
                ->setCredentialTreatment('MD5(?)')
        ;
        $result = parent::authenticate($adapter);
        
        $data = null;
        if ($result->isValid()) {
            $storage = $this->getStorage();
            $data = $adapter->getResultRowObject(null, 'senha');
            $this->_user = $data;
            $storage->write($data);
            return true;
        }
        return false;
    }

    /**
     * Set the auth adapter
     *
     * @param $authadapter
     * @return Far_Auth
     */
    private function setAdapter($authadapter)
    {
        $this->_adapter = $authadapter;
        return $this;
    }

}
