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
 * Serve de abstracao para controlo de privilegioc de um target
 * 
 * @author andref
 * @version $Id: Privileges.php 6 2011-09-04 15:59:45Z andref $
 *
 */
class Users_Model_Privileges extends Zend_Db_Table_Abstract
{

    protected $_name = 'privilege_controller';
    
    protected $_primary = 'idprivilege';
    
    protected $_sequence = true;
    
    protected $_referenceMap    = array(
        'Groups' => array(
            'columns'           => array('idacgroup'),
            'refTableClass'     => 'Users_Model_Groups',
            'refColumns'        => array('idacgroup')
        )
    );

    public function getGroups($module, $controller, $action)
    {
        $sel = $this->select();

        $sel->where("modulename = ? ", $module);

        $sel->Where("controllername = ? ", $controller);

        $sel->Where("controlleraction = ? ", $action);

        return $this->fetchAll($sel);
    }
    
    public function getAccess($idgroup)
    {
        return $this->fetchAll("idacgroup = " . (int) $idgroup);
    }

}