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
 * Descreve a tabela utilizadores
 *
 * @author andref
 *
 * @package Far
 * @subpackage Access
 * @version $Id$
 */

class Users_Model_Users extends Zend_Db_Table_Abstract
{
	protected $_name = 'acusers';
	protected $_primary = 'idacuser';
	protected $_sequence = true;

	protected $_rowClass = 'Users_Model_User';

    protected $_referenceMap = array(
        "groupusers" => array(
            "columns" => "idacuser",
            "refTableClass" => "Users_Model_UsersGroups",
            "refColumns" => "idacuser"
        )
    );

	public function getById($id)
	{
            $select  = $this->select()
                    ->from($this->_name, "idacuser, login, name, email, state ")
                    ->where('idacuser = ?', (int)$id);
            $row = $this->fetchRow($select);
            return $row;
	}
    /**
     * get all except the ones in the array
     *
     * Verify the input safety outside the query
     *
     * @param array $idArray
     * @return Zend_Db_Table_Rowset
     */
    public function getAllExcept(array $idArray)
    {
        $list = implode(",", $idArray);
        if (empty($list)) {
            return $this->fetchAll();
        }

        return $this->fetchAll("acusers.idacuser NOT IN ($list)");
    }

    public function hasLogin($login, $id)
    {
        $sel = $this->select()->from($this->_name);
        $sel->where("login = ? AND idacuser != " . (int) $id , $login);

        return ($this->fetchAll($sel)->count() > 0 ) ? true : false ;
    }
}
