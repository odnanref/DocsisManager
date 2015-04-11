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
 * Description of Lease
 *
 * @author andref
 */
class Network_Model_Leases extends Zend_Db_Table_Abstract
{
    protected $_name = '';
    protected $_primary = 'idlease';

    public function setTblName(\DateTime $date)
    {
        $this->_name = "historiclease" . $date->format("dmY");

        $sql = "CREATE TABLE IF NOT EXISTS " .
                $this->_name
                . " ( idlease int auto_increment , ordem varchar(254),
                    ip varchar(254), macaddr varchar(254), remoteid varchar(254),
                    data timestamp, primary key(idlease))";

        $Adapter = $this->getAdapter();
        $Adapter->query($sql);

        return $this;
    }

    public function getTblName()
    {
//        $table = new Zend_Db_Table("historiclease" . (int) $day . (int) $month .
//                        (int) $year);
        return $this->_name;
    }

    protected $_sequence = true; // YOU SHOULD NOT INSERT

    public function __construct(array $config = array())
    {
        parent::__construct($config);
    }

    public function findLease($ip, \DateTime $date)
    {
        $day    = $date->format("d");
        $month  = $date->format("m");
        $year   = $date->format("Y");

        $this->setTblName($date);

        $sel = $this->select();
        $sel->setIntegrityCheck(false);
        $sel->from("historiclease" . (int) $day . (int) $month . (int) $year);
        $sel->where("ip = ?", $ip);
        $sel->order("data DESC");

        return $this->fetchAll($sel);
    }
}
