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
 * To record CM changes by user
 *
 * @author andref
 */
class DM_Model_DMhistory extends Zend_Db_Table
{
    protected $_name = 'dmhistory';
    protected $_primary = 'iddmhistory';
    protected $_sequence = false;
    protected $_dependentTables = array('DM_Model_Docsismodems');
    protected $_referenceMap = array(
        'DM_Model_Docsismodems' => array(
            'columns' => 'macaddr',
            'refTableClass' => 'DM_Model_Docsismodems',
            'refColumns' => 'macaddr'
        )
    );

    public function saveData(array $Data)
    {
//        $Data["user"] = $Data['login'];

        unset($Data['first_online']);
        unset($Data['last_online']);
        unset($Data['reg_count']);
//        unset($Data['login']);
//        unset($Data['senha']);
//        unset($Data['name']);
//        unset($Data['email']);
//        unset($Data['state']);

        return $this->insert($Data);
    }
}
