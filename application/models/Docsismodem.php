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

define("DM_READ_COMMUNITY", "stvtelecom.pt1", true);
define("DM_WRITE_COMMUNITY", "stvtelecom.pt1write12", true);

/**
 * Remote interact with CM and with it's information on the database
 *
 * @author andref
 * @version $Id$
 */
class DM_Model_Docsismodem extends Zend_Db_Table_Row_Abstract
{
    /**
     *
     * @var DM__Model_Docsismodems
     */
    protected $_table;

    protected $_data = array(
        'macaddr'           => '',
        'config_file'       => '',
        'config_file_mta'   => '',
        'ipaddress' => '',
        'estado'    => '',
        'serialnum' => '',
        'ipaddr'    => '',
        'idmodel'   => '',
        'first_online'  => '',
        'last_online'   => '',
        'reg_count' => '',
        'cmts_vlan' => '',
        'subnum'    => '',
        //'ipaton' => '',
        'idbrand'   => '',
        'name'      => '',
        'descricao' => '',
        'vendormac' => '',
        'lastip'    => '',
        'tel1'      => '',
        'tel2'      => '',
        'node'      => ''
    );

    protected $RemoteQuery;

    protected $OnlineReg;

    /**
     * returns available IP
     * @deprecated
     * @return string $Ipaddr
     */
    public function getNewIP()
    {
        //select ipaddr from docsismodem order by ipaton desc
        $select = $this->select()->from("docsismodem", array("newip" => "max(INET_ATON(ipaddr))"));
        $stmt = $select->query();
        $r = $stmt->fetchAll();
        ++$r[0]['newip'];

        if ($r[0]['newip'] <= 1 ) {
            $r[0]['newip'] = ip2long("10.0.1.2");
        }
        $newip = long2ip($r[0]['newip']);
        return $newip;
    }

    /**
     *
     * @param Array|null $options
     */
    public function __construct($options = array())
    {
        if (class_exists("DM_Model_Docsismodems")) {
            $this->_table = new DM_Model_Docsismodems();
        }
        parent::__construct($options);
    }

    private function cleanPersonal()
    {
        unset($this->_data['idbrand']);
        unset($this->_data['name']);
        unset($this->_data['description']);
        unset($this->_data['vendormac']);

        unset($this->_cleanData['idbrand']);
        unset($this->_cleanData['name']);
        unset($this->_cleanData['description']);
        unset($this->_cleanData['vendormac']);

        if ($this->OnlineReg !== null ) {
            unset($this->OnlineReg);
        }
    }


    public function save()
    {
        if (count($this->_cleanData) <= 0 ) {
            $sel = $this->_table->select()->where("macaddr = ? ", $this->macaddr);
            $res = $this->_table->fetchAll($sel);
            if ($res->count() > 0 ) {
                throw new Exception("Já existe um MAC igual a este " .
                        $this->macaddr
                        );
            }
        }

        if ( !empty($this->serialnum) && !empty($this->macaddr)) {
            $sel = $this->_table->select()->where("macaddr <> ? ", $this->macaddr);
            $sel->where("serialnum = ? ", $this->serialnum);
            $res = $this->_table->fetchAll($sel);
            if ($res->count() > 0 ) {
                throw new Exception("Já existe um número de série igual em outro MAC");
            }
        }

        if (empty($this->ipaddr)) {
            $this->ipaddr = $this->getNewIP();
        }
        $this->setReadOnly(false);

        $this->cleanPersonal();

        return parent::save();
    }

    public function remoteQuery($community = 'public')
    {
        if (empty($this->macaddr) || empty($this->lastip)) {
            return null;
        }
        $last_err = error_reporting();
        error_reporting(0);
        $ip   = str_replace("0.0.", "10.1.", $this->lastip);
        $this->RemoteQuery['ip'] = $ip;
        $this->RemoteQuery['community'] = $community;

        $this->RemoteQuery['tx']       = $this->getTX();
        if ($this->RemoteQuery['tx'] === null ) {
            $this->RemoteQuery['community'] = DM_READ_COMMUNITY;
            $this->RemoteQuery['tx']       = $this->getTX();
        }
        $this->RemoteQuery['snr']      = $this->getSNR();
        $this->RemoteQuery['rx']       = $this->getRX();
        $this->RemoteQuery['version']  = $this->getFirmwareVersion();
        $this->RemoteQuery['microreflections']  = $this->getMicroreflections();
        $this->RemoteQuery['imagefile']         = $this->getImagefile();
        $this->RemoteQuery['uptime']            = $this->getUptime();
        $this->RemoteQuery['downstreamfreq']    = $this->getDownstreamFreq();
        $this->RemoteQuery['upstreamfreq']      = $this->getUpstreamFreq();
        $this->RemoteQuery['channelwidth']      = $this->getChannelWidth();
        $this->RemoteQuery['uschannelid']       = $this->getUSChannelId();
        $this->RemoteQuery['dschannelid']       = $this->getDSChannelId();
        $this->RemoteQuery['log']               = $this->getLogs();

        error_reporting($last_err);

        return $this->RemoteQuery;

    }

    private function getTX()
    {
        return $this->getRemote($this->RemoteQuery['ip'], ".1.3.6.1.2.1.10.127.1.2.2.1.3.2", $this->RemoteQuery['community']);
    }

    private function getRX()
    {
        return $this->getRemote($this->RemoteQuery['ip'], ".1.3.6.1.2.1.10.127.1.1.1.1.6.3", $this->RemoteQuery['community']);
    }

    private function getSNR()
    {
        return $this->getRemote($this->RemoteQuery['ip'], ".1.3.6.1.2.1.10.127.1.1.4.1.5.3", $this->RemoteQuery['community']);
    }

    private function getMicroreflections()
    {
        return $this->getRemote($this->RemoteQuery['ip'], ".1.3.6.1.2.1.10.127.1.1.4.1.6.3", $this->RemoteQuery['community']);
    }

    private function getImagefile()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                ".1.3.6.1.2.1.69.1.4.5.0",
                $this->RemoteQuery['community']
                );
    }

    private function getUptime()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                ".1.3.6.1.2.1.1.3.0",
                $this->RemoteQuery['community'],
                null
                );
    }

    private function getHosts()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                ".1.3.6.1.2.1.17.4.3.1.1.0",
                $this->RemoteQuery['community']
                );
    }

    private function getLogs()
    {
        $var = snmpwalk($this->RemoteQuery['ip'],
                $this->RemoteQuery['community'],
                ".1.3.6.1.2.1.69.1.5.8.1.7"
                );

        $Data = "";
        if ($var !== null && count($var) > 0) {
            foreach ($var as $value) {
                $Data .= $value."\n";
            }
        }
        $Data = str_replace("STRING:", "", $Data);
        return $Data;
    }

    private function getDownstreamFreq()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                ".1.3.6.1.2.1.10.127.1.1.1.1.2.3",
                $this->RemoteQuery['community']
                );
    }

    private function getUpstreamFreq()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                ".1.3.6.1.2.1.10.127.1.1.2.1.2.4",
                $this->RemoteQuery['community']
                );
    }

    public function getUSChannelId()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                ".1.3.6.1.2.1.10.127.1.1.2.1.1.4",
                $this->RemoteQuery['community']
                );
    }

    public function getDSChannelId()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                "1.3.6.1.2.1.10.127.1.1.1.1.1.3",
                $this->RemoteQuery['community']
                );
    }

    private function getChannelWidth()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                ".1.3.6.1.2.1.10.127.1.1.2.1.3.4",
                $this->RemoteQuery['community']
                );
    }

    public function getCMResets()
    {
        return $this->getRemote(
                $this->RemoteQuery['ip'],
                "1.3.6.1.2.1.10.127.1.2.2.1.4.2",
                $this->RemoteQuery['community']
                );
    }

    public function getCPEs()
    {
        // Get the Mac and device type from the OIds
        $cpes = snmpwalk($this->lastip, DM_WRITE_COMMUNITY, ".1.3.6.1.2.1.17.4.3.1.1");
        $type = snmpwalk($this->lastip, DM_READ_COMMUNITY, ".1.3.6.1.2.1.17.4.3.1.3");
        // look at each one
        $modemclients = array();
        $ccpes = count($cpes);
        for($t = 0; $t < $ccpes; $t++) {
            if (preg_replace(".*= ", "", $type[$t]) !='4') {
                $modemclients[$t] = preg_replace("^e", "", preg_replace(".*= |Hex:|[^0-9A-Fa-f]", "", $cpes[$t]));
            }
        }

        return $modemclients;
    }

    private function getFirmwareVersion()
    {
        $str = ($this->getRemote($this->RemoteQuery['ip'], "1.3.6.1.2.1.1.1.0", $this->RemoteQuery['community'], null));
        $str = str_replace("\"", "", $str);
        $str = str_replace("STRING: ", "", $str);
        $a_str = explode("<<", $str);
        if (count($a_str) > 0 ) {
            $cmType = $a_str[0];
            $this->RemoteQuery["cmType"] = $cmType;
            if (array_key_exists(1, $a_str)) {
                $details = explode(";", str_replace(">>", "", $a_str[1]));
            } else {
                $details = array();
            }
            if (count($details) <= 0 ) {
                $this->RemoteQuery['detailInfo'] = array();
                return $cmType;
            }

            $detailInfo = array();
            foreach ($details as $v ) {
                $k = explode(":", $v);
                if (count($k) > 0 ) {
                    $this->RemoteQuery['detailInfo'][ trim($k[0]) ] = trim($k[1]);
                }
            }

           return $cmType;
        } else {
            return htmlentities($str);
        }
    }

    public function getremoteDetailInfo()
    {
        if (array_key_exists("detailInfo", $this->RemoteQuery)) {
            return $this->RemoteQuery['detailInfo'];
        }
        return null;
    }

    private function getRemote($ipaddr, $oid, $community, $separator = ":")
    {
        if ($separator === null ) {
            return snmpget($ipaddr, $community, $oid);
        }

        $tmp = explode($separator, snmpget($ipaddr, $community, $oid));
        if ($oid == ".1.3.6.1.2.1.69.1.5.8.1.7") {
            print " $ipaddr $community $oid  - " . snmpget($ipaddr, $community, $oid);exit;
        }
        if (!array($tmp)) {
            return null;
        }

        if (array_key_exists(1, $tmp)) {
            return $tmp[1];
        } else {
            return null;
        }
    }

    public function lastRegistered()
    {
        if (empty($this->macaddr)) {
            return null;
        }
        $this->OnlineReg = $this->_table->getCMLastACK(
                            date( "j" ),
                            date( "n"), date( "Y" ), $this->macaddr
                            );
        return $this->OnlineReg;
    }

    public function disable()
    {
        $this->cleanPersonal();
        $this->config_file = null;
        $this->estado = 'anulado';
        $this->save();
    }

    public function cmreset()
    {
        return snmpset($this->lastip, DM_WRITE_COMMUNITY,
                ".1.3.6.1.2.1.69.1.1.3.0","i",1);
    }

}

