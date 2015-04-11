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
 * Groups
 * 
 * @author andref
 * @version $Id: Groups.php 6 2011-09-04 15:59:45Z andref $
 * 
 * 
 */

class Users_Model_Groups extends Zend_Db_Table_Abstract
{
	protected $_name = 'acgroups';
	protected $_primary = 'idacgroup';
    
	protected $_sequence = true;

	protected $_rowClass = 'Users_Model_Group';
    
    protected $_referenceMap    = array(
        'GroupsUsers' => array(
            'columns'           => array('idacgroup'),
            'refTableClass'     => 'Users_Model_GroupsUsers',
            'refColumns'        => array('idacgroup')
        ),
        'Privileges' => array(
            'columns'           => array('idacgroup'),
            'refTableClass'     => 'Users_Model_Privileges',
            'refColumns'        => array('idacgroup')
        )
    );
    
    public function getById($id)
	{
            $select  = $this->select()
                    ->from($this->_name, "idacgroup, name, admin ")
                    ->where('idacgroup = ' . (int)$id);
            $row = $this->fetchRow($select);
            return $row;
	}
    
    public function getAllByUser($id)
    {
        if (($id instanceof Users_Model_User)) {
            $id = (int) $id->idacuser;
        }
        
        $sel = $this->select()->from($this->_name);
        $sel->setIntegrityCheck(false);
        $sel->joinInner("acgroups_acusers", 
                "acgroups.idacgroup = acgroups_acusers.idacgroup")->columns();
        $sel->where("acgroups_acusers.idacuser = " . (int) $id);
        
        return $this->fetchAll($sel);
    }
    
    public function getAllExcept(array $idArray)
    {
        $list = implode(",", $idArray);
        if (empty($list)) {
            return $this->fetchAll();
        }
        
        return $this->fetchAll("acgroups.idacgroup NOT IN ($list)");
    }
}