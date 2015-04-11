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
 * DocsisSignal view the information collected from vertx.php
 * from remote cable modems
 *
 * @author andref
 * @version $Id$
 */
class DM_Model_DocsisSignal extends Zend_Db_Table_Abstract
{

    protected $_name = 'docsissignal';
    protected $_primary = 'idtx';
    protected $_sequence = false;
    protected $_dependentTables = array('DM_Model_Docsismodems');
    protected $_referenceMap = array(
        'DM_Model_Docsismodems' => array(
            'columns' => 'macaddr',
            'refTableClass' => 'DM_Model_Docsismodems',
            'refColumns' => 'macaddr'
        )
    );

    public function get($mac, $date = null)
    {
        $sel = $this->select()->from($this->_name, 'idtx, (tx/10) as tx ,
            (snr/10) as snr , (rx/10) as rx, microreflections,
            dschannelid, uschannelid, data
                    , docsismodem.macaddr, docsismodem.node');
        $sel->setIntegrityCheck(false);

        if ($date !== null) {
            $sel->where("data  = ? ", $date->getTimestamp());
        }
        $sel->joinInner("docsismodem",
                "docsissignal.macaddr = docsismodem.macaddr",
                "lastip");

        $sel->where("docsissignal.macaddr = ? ", $mac);
        $sel->order("data DESC");
        return $this->fetchAll($sel);
    }

    /**
     * get faulty cm's from table
     *
     * @param DateTime $date
     * @return type
     */
    public function getFaulty(DateTime $date = null)
    {
        $seld = $this->select()->from($this->_name, "MAX(data) as data");
        $Data = $this->fetchRow($seld);
        if ($Data === null ) {
            return null;
        }

        $sel = $this->select()->from($this->_name, 'idtx, (tx/10) as tx , (snr/10) as snr , (rx/10) as rx,
                    microreflections, dschannelid, uschannelid, data, docsissignal.macaddr, docsismodem.node');
        $sel->setIntegrityCheck(false);
        $sel->joinInner("docsismodem", "docsissignal.macaddr = docsismodem.macaddr", "lastip");
        // TODO Have to do this
        // select * from docsissignal
        // where DATE_FORMAT(data, '%Y-%m-%d') = DATE_FORMAT((SELECT DATE_FORMAT(MAX(data), '%Y-%m-%d')
        // from docsissignal), '%Y-%m-%d') and (( (tx/10) > 52) or ( (tx/10) < 34)) and (( (rx/10) > 11) or ( (rx/10) < -10));
        if ($date === null) {
            $sel->where(
                    //(SELECT DATE_FORMAT(MAX(data), '%Y-%m-%d') FROM docsissignal)
                    new Zend_Db_Expr(" data >=
                    DATE_ADD( '" . $Data->data . "' , INTERVAL -3 HOUR)")
            );
        }
        $sel->where("(
            ((tx/10) > 52) OR ((tx/10) < 32) OR
            ((rx/10) > 13) OR ((rx/10) < -13) OR
            (snr < 32) ) ");

        $sel->group("macaddr");
        $sel->order("data ASC");

        return $this->fetchAll($sel);
    }

    public function search($filter = array())
    {
        $sel = $this->select()
                ->from($this->_name,
                        'idtx, (tx/10) as tx , (snr/10) as snr , (rx/10) as rx,
                    microreflections, dschannelid, uschannelid,
                    data, docsissignal.macaddr, lastip, docsismodem.node');
        $sel->setIntegrityCheck(false);
        $sel->joinInner("docsismodem",
                "docsissignal.macaddr = docsismodem.macaddr", "lastip");
        $tk = array_keys($filter);

        $known_fields = ['macaddr', 'ipaddr', 'node', 'data1', 'data2',
            'tx1', 'tx2', 'snr1', 'snr2',
            'rx1', 'rx2', 'mr1', 'mr2'];

        if ( (array) $tk != $known_fields) {
            throw new Zend_Exception("fields not found in array " .
                    implode( ", ",array_diff($tk, $known_fields))
                    );
        }
        $hit = false;
        $temp = "";
        foreach ($filter as $k => $v) {
            if ((!is_array($v) && empty($v)) || ( is_array($v) && empty($v['value']))) {
                continue;
            }

            if (($k != 'macaddr' || $k != 'data' || $k != 'ipaddr' || $k != 'node') &&
                    ( is_array($v) &&
            !in_array($v['mark'], ['=', '>=', '<=', '<', '>']) ) ) {
                print $k;
                exit;
                throw new Zend_Exception("mark sign not in array");
            } else if ($k == 'macaddr' || $k == 'ipaddr' || $k == 'node') {
                if ($k == 'macaddr') {
                    $hit    = true;
                    $k      = 'docsissignal.macaddr';
                }
                $tmp = $v;
                $v = array();
                $tmp = addslashes($tmp);
                $value = "'$tmp'";
                $mark = "=";
                $tk = $k;
            } else if ( ($k == 'data1' || $k == 'data2')) {
                if (!array_key_exists("data1", $filter))
                        continue;

                $sel->where(" data >= '" . $filter["data1"] . "' AND
                    data <= '" . $filter["data2"] . "'" );

                unset($filter["data1"], $filter["data2"]);

                continue;

            } else {
                if ($k == 'mr1' || $k == 'mr2') {
                    $k = str_replace("mr", "microreflections", $k);
                }

                $tk = substr($k, 0, strlen($k) - 1);
                $mark = $v['mark'];
                $value = (double) ($v['value'] * 10);
            }
            if (strlen($temp) <= 0 ) {
                $temp .= " ($tk $mark $value ) ";
            } else {
                $temp .= " OR ($tk $mark $value ) ";
            }

            if ($k == 'ipaddr') {
                $sel->Where(" lastip like $value ");
            }
        }

        $sel->Where($temp);
        $sel->order("data DESC");
        if (!$hit) {
            $sel->group("docsissignal.macaddr");
        }

        return $this->fetchAll($sel);
    }

    public function getByDate(DateTime $data, $macaddr)
    {
        $sel = $this->select()->from($this->_name,
                'idtx, (tx/10) as tx , (snr/10) as snr , (rx/10) as rx,
                    microreflections, data, macaddr');
        $sel->setIntegrityCheck(false);
        $sel->where("macaddr = ?", $macaddr);
        $sel->where("DATE_FORMAT(data, '%Y-%m-%d') = ? ", $data->format("Y-m-d"));
        $sel->order("data DESC");
        return $this->fetchAll($sel);
    }

}
