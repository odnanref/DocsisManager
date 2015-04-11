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
 * Description of UsersGroups
 *
 * @author andref
 * @version $Id$
 */
class Users_Model_UsersGroups extends Zend_Db_Table_Abstract
{
	protected $_name    = 'acgroups_acusers';
    
    protected $_primary = array('idacuser', 'idacgroup');
	
    protected $_referenceMap    = array(
        'Group' => array(
            'columns'           => array('idacgroup'),
            'refTableClass'     => 'Users_Model_Groups',
            'refColumns'        => array('idacgroup')
        ),
        'User' => array(
            'columns'           => array('idacuser'),
            'refTableClass'     => 'Users_Model_Users',
            'refColumns'        => array('idacuser')
        )
    );
    
    /**
     * join a user to a group
     * 
     * @param type $user
     * @param type $group
     * @return boolean
     */
    public function join($user, $group)
    {
        if ( ($user instanceof Users_Model_User) ) {
            $user = $user->idacuser;
        }
        
        if ( ($group instanceof Users_Model_Group) ) {
            $group = $group->idacgroup;
        }
        
        if (empty($user) || empty ($group)) {
            throw new Exception("User or Group is empty or zero");
        }
        
        $join = $this->fetchRow("idacuser = " . (int) $user . " AND idacgroup = " . (int) $group);
        if ($join === null ) {
            $res = $this->insert(array('idacuser' => (int) $user, 'idacgroup' => (int) $group));
            if ($res <= 0 )
                return false;
        }
        
        return true;
    }
    /**
     * Unjoin the user from the group
     * 
     * @param type $user
     * @param type $group
     * @return boolean
     */
    public function unjoin($user, $group)
    {
        if ( ($user instanceof Users_Model_User) ) {
            $user = $user->idacuser;
        }
        
        if ( ($group instanceof Users_Model_Group) ) {
            $group = $group->idacgroup;
        }
        
        if (empty($user) || empty ($group)) {
            throw new Exception("User or Group is empty or zero");
        }
        
        $join = $this->fetchRow("idacuser = " . (int) $user . " AND idacgroup = " . (int) $group);
        if ($join !== null ) {
            $res = $this->delete('idacuser = ' . (int) $user. ' AND idacgroup = '. (int) $group);
            if ($res <= 0 )
                return false;
        }
        
        return true;
    }
    
    public function userInGroup($idu, $idg) 
    {
        $r = $this->fetchRow("idacuser = " . (int) $idu . " AND idacgroup = " . (int) $idg);
        if ($r === null) {
            return false;
        } else {
            return true;
        }
    }
}
