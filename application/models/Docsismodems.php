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

define("DEFAULT_CM_PATH", APPLICATION_PATH . "/cm_templates/", true);
define("DEFAULT_CM", "DEFAULT.cfg", true);

/**
 * Description of Docsismodems
 *
 * @author andref
 * @version $Id$
 *
 */
class DM_Model_Docsismodems extends Zend_Db_Table_Abstract
{

    protected $_name = 'docsismodem';

    protected $_primary = 'macaddr';

    protected $_sequence = false;

    protected $_rowClass = 'DM_Model_Docsismodem';

    protected $_dependentTables = array('DM_Model_Model');

    protected $_referenceMap = array(
        'DM_Model_Model' => array(
            'columns' => 'idmodel',
            'refTableClass' => 'DM_Model_Model',
            'refColumns' => 'idmodel'
        )
    );

    public function validarMac($mac)
    {
        $validator = new Zend_Validate_Regex('/([a-fA-F0-9]{2}[:|\-]?){6}/');
        return $validator->isValid($mac);
    }

    /**
     * get modem id by mac address
     *
     * @param string $macaddress
     * @return DM_Model_Docsismodem
     */
    public function getById($macaddress)
    {
        if ($this->validarMac($macaddress) === false) {
            return null;
        }

        $select = $this->select()->from(array("dm" => "docsismodem"))->setIntegrityCheck(false);
        $select->joinLeft(
                        "model", "model.idmodel = dm.idmodel",
                array('model.idmodel', 'model.description', 'model.vendormac')
                )
                ->joinLeft("brand", "model.idbrand=brand.idbrand",
                            new Zend_Db_Expr("name,
                                IFNULL(model.default_file, brand.default_file) as default_file,
                                IFNULL(model.default_file_phone_on, brand.default_file_phone_on) as default_file_phone_on,
                                IFNULL(model.default_file_mta, brand.default_file_mta) as default_file_mta,
                                IFNULL(model.onefilemta, brand.onefilemta) as onefilemta,
                                IFNULL(model.default_file_mta_2l, brand.default_file_mta_2l) as default_file_mta_2l")
                            )
                ->where("macaddr = ? ", $macaddress);

        $row = $this->fetchRow($select);
        return $row;
    }

    public function getActivos()
    {
        $sel = $this->select()
                ->where("estado = 'activo'")
                ->order("last_online DESC");
        return $this->fetchAll($sel);
    }

    public function getInactivos()
    {
        $sel = $this->select()
                ->where("estado = 'cortado' OR estado = 'inactivo' ")
                ->order("last_online DESC");

        return $this->fetchAll($sel);
    }

    /**
     * Pesquisa rápida
     *
     * @param array $where
     * @return Array
     */
    public function search($where)
    {
        $q = '';
        $seen = false;
        $sel = $this->select()->from($this->_name);

        $sel->setIntegrityCheck(false);

        foreach ($where as $k => $v) {
            if (($k == 'ipaddr' || $k == 'lastip') && $seen !== true) {
                $sel->where(" ipaddr = ? ", $v);
                $sel->orWhere("lastip = ? ", $v);

                $seen = true;
            } else if ($k == 'phone') {
                $sel->where("tel1 = " . (int) $v . " OR tel2 = " . (int) $v);
            }
            else {
                $v = str_replace("*", "%", $v);
                $sel->where($k . " LIKE ? ", $v);
                $sel->order("last_online DESC");
            }
        }

        return $this->fetchAll($sel);
    }

    /**
     * get last registered time
     *
     * @param int $day
     * @param int $month
     * @param int $year
     * @param string macaddr
     *
     * @return Array
     */
    public function getCMLastACK($day, $month, $year, $macaddr)
    {
        $day = (int) $day; $month = (int) $month; $year = (int) $year;

        $sql = "CREATE TABLE IF NOT EXISTS " . "historiclease" .
                $day . $month . $year
                . " ( idlease int auto_increment , ordem varchar(254),
                    ip varchar(254), macaddr varchar(254), remoteid varchar(254),
                    data timestamp, primary key(idlease))";

        $Adapter = $this->getAdapter();
        $Adapter->query($sql);
        $table = new Zend_Db_Table("historiclease" . (int) $day . (int) $month .
                        (int) $year);
        $sel = $table->select();
        $sel->setIntegrityCheck(false);
        $sel->from("historiclease" . (int) $day . (int) $month . (int) $year);
        $sel->where("remoteid = ?", $macaddr);
        $sel->order("data DESC");

        return $table->fetchAll($sel);
    }

    public function getCMLastACKByDate(DateTime $data, $macaddr)
    {
        $data->getTimestamp();
        $t      = $data->getTimestamp();
        $day    = date("d", $t);
        $month  = date("m", $t);
        $year   = date("Y", $t);

        return $this->getCMLastACK($day, $month, $year, $macaddr);
    }

    public function getCMLastRXByDate(DateTime $data, $macaddr)
    {
        $ds = new DM_Model_DocsisSignal();
        return $ds->getByDate($data, $macaddr);
    }

    public function genFile($macaddr, $up, $down, $out, $options = array())
    {
        $res = $this->getById($macaddr);
        if ($res === null) {
            throw new Exception("Mac Address not found.");
        }

        $gen = new Far_Docsis_GenCMFile();
        $gen->setMacAddr($macaddr);
        $gen->setConfigPath(DEFAULT_CM_PATH);

        if (count($options) > 0) {
            if (array_key_exists("snmpread", $options)) {
                $gen->setSnmpRead($options["snmpread"], 1);
            }

            if (array_key_exists("snmpwrite", $options)) {
                $gen->setSnmpWrite($options["snmpwrite"], 1);
            }

            if (array_key_exists("swupgradeserver", $options)) {
                $gen->setSWUpgradeServer($options["swupgradeserver"]);
            }

            if (array_key_exists("voipserver", $options)) {
                $gen->addVoipServers($options["voipserver"]);
            }
        }

        if (empty($res->default_file)) {
            $res->default_file = DEFAULT_CM;
        }

        if (empty($res->default_file_phone_on)) {
            $res->default_file_phone_on = $res->default_file;
        }

        $gen->setDefaultCMFile($res->default_file);
        $gen->setDefaultCMFilePhoneOn($res->default_file_phone_on);

        if (!empty($res->default_file_mta)) {
            $gen->setDefaultMtaFile($res->default_file_mta);
        }

        if (!empty($res->default_file_mta_2l)) {
            $gen->setDefaultMtaFile2L($res->default_file_mta_2l);
        }

        $gen->setOneFileMta($res->onefilemta);

        if (!empty($res->tel1)) {
            $gen->setPhone($res->tel1, 1);
            $gen->setLineAuth(1, $res->tel2, $res->tel2, $res->tel2);
        }

        if (!empty($res->tel2)) {
            $gen->setPhone($res->tel2, 2);
            $gen->setLineAuth(2, $res->tel2, $res->tel2, $res->tel2);
        }

        if (!empty($out) || $out !== null) {
            $gen->setFileOut($out);
        }

        if (!empty($res->idmodel)) {
            $gen->setIdModel($res->idmodel);
        }

        $gen->setDownload($down);
        $gen->setUpload($up);

        try {
            $gen->generate();
        } catch (Exception $e) {
            print $e->getMessage();
            return false;
        }


        if ($gen->isSuccess() === true) {
            if (!$gen->isMta()) {
                $r = $this->update(array("config_file" => $gen->getFileOut())
                        , "macaddr = '" . $res->macaddr . "'");
            } else {
                if ($gen->isOneFileMta()) {
                    $r = $this->update(array(
                        "config_file" => $gen->getFileOut('mta'))
                            , "macaddr = '" . $res->macaddr . "'");
                } else {
                    $r = $this->update(array(
                        "config_file" => $gen->getFileOut()
                        , "config_file_mta" => $gen->getFileOut('mta')
                            )
                            , "macaddr = '" . $res->macaddr . "'");
                }
            }

            return $r;
        } else {
            $tmpOut = "";
            if ( ($c = count($gen->getOutput())) > 0 ) {
                $arr = $gen->getOutput();
                for ($x=0 ; $x < $c ; $x++) {
                   $tmpOut .= $arr[$x];
                }
            }
            throw new Exception($tmpOut);
            return false;
        }

        return true;
    }

    public function genMtaFile($macaddr, $speedup, $speeddown, $filename, $options = array())
    {
        $res = $this->getById($macaddr);
        if ($res === null) {
            throw new Exception("Mac Address not found.");
        }

        $gen = new Far_Docsis_GenCMFile();
        $gen->setMacAddr($macaddr);
        $gen->setConfigPath(DEFAULT_CM_PATH);

        if (count($options) > 0) {
            if (array_key_exists("snmpread", $options)) {
                $gen->setSnmpRead($options["snmpread"], 1);
            }

            if (array_key_exists("snmpwrite", $options)) {
                $gen->setSnmpWrite($options["snmpwrite"], 1);
            }

            if (array_key_exists("swupgradeserver", $options)) {
                $gen->setSWUpgradeServer($options["swupgradeserver"]);
            }

            if (array_key_exists("voipserver", $options)) {
                $gen->addVoipServers($options["voipserver"]);
            }
        }

        $gen->setOnlyMta(true);

        if (empty($res->default_file)) {
            $res->default_file = DEFAULT_CM;
        }

        $gen->setDefaultCMFile($res->default_file);

        if (!empty($res->default_file_mta)) {
            $gen->setDefaultMtaFile($res->default_file_mta);
        }

        $gen->setOneFileMta($res->onefilemta);

        if (!empty($res->tel1)) {
            $gen->setPhone($res->tel1, 1);
        }

        if (!empty($res->tel2)) {
            $gen->setPhone($res->tel2, 2);
        }

        if (!empty($out)) {
            $gen->setFileOut($out);
        }

        $gen->setDownload($down);
        $gen->setUpload($up);

        $gen->generate();

        if (count($options) > 0) {
            if (array_key_exists("prebuilt_file", $options)) {
                $gen->setFileOut($options['prebuilt_file']);
            }
        }

        if ($gen->isSuccess() === true) {
            if (!$gen->isMta()) {
                $r = $this->update(array("config_file" => $gen->getFileOut())
                        , "macaddr = '" . $res->macaddr . "'");
            } else {
                if ($gen->isOneFileMta()) {
                    $r = $this->update(array(
                        "config_file" => $gen->getFileOut('mta'))
                            , "macaddr = '" . $res->macaddr . "'");
                } else {
                    $r = $this->update(array(
                        "config_file" => $gen->getFileOut()
                        , "config_file_mta" => $gen->getFileOut('mta')
                            )
                            , "macaddr = '" . $res->macaddr . "'");
                }
            }

            if ($r <= 0) {
                throw new Exception("File generate but failed updating the DB.");
            }
        }

        return true;
    }

    public function getFilesInUse($having = 1)
    {
        $sel = $this->select()
                ->from($this->_name, "config_file, count(*) as t")
                ->group("config_file")
                ->having(" t > " . (int) $having )
        ;

        return $this->getAdapter()
                        ->query($sel)
                        ->fetchAll()
        ;
    }

    public function getMoreRegs()
    {
        $sel = $this->select();
        $sel->from($this->_name, array("macaddr", "reg_count"))
                ->where("estado = 'activo'")
                ->order("reg_count DESC")
                ->limit(16);

        return $this->fetchAll($sel);
    }

    public function newEquipment(Client_Model_Device $dev)
    {
        $row = $this->fetchRow("macaddr = '" . $dev->macaddr . "'");
        if ($row === null) {
            $dm = new DM_Model_Docsismodem();
            $dm->macaddr = $dev->macaddr;
            $dm->serialnum = $dev->serialnum;
            $dm->estado = "cortado"; // no service
            $dm->idmodel = $dev->idmodel;

            $id_dm = $dm->save();

            if ($id_dm <= 0) {
                throw new Zend_Exception(
                        "Unable to create equipment in docsis modem. " .
                        $dev->macaddr . " id:$id_dm "
                );
            }
        } else {
//            if (!empty($dev->idmodel)) {
//                $row->idmodel = $dev->idmodel;
//            }
            $row->disable();
        }
    }

    public function getAllVoip( $estado = 'all')
    {
        $tmp = "";
        $sel = $this->select()->where("tel1 IS NOT NULL OR tel2 IS NOT NULL");

        if ($estado == 'activo') {
            $sel->where("estado = 'activo' ");
        } else if ($estado == 'inactivo' ) {
            $sel->where("(estado != 'activo' OR config_file like '%desligado%')");
        } else {
            switch ($estado) {
                case "cortado" : $sel->where("estado = 'cortado' "); break;
                case "anulado" : $sel->where("estado = 'anulado' "); break;
            }
        }

        return $this->fetchAll($sel);
    }
    /**
     * First time online count by month
     *
     * @return Zend_Db_Table_Rowset
     */
    public function getTotalActiveByMonth($year)
    {
        $sel = $this->select()->from($this->_name, new Zend_Db_Expr("count(macaddr) as t,
            DATE_FORMAT(first_online, '%m') as first_online")
                );
        $sel->where("DATE_FORMAT(first_online, \"%Y\") = ? ", $year)
                ->group("DATE_FORMAT(first_online, '%Y-%m')");

        return $this->fetchAll($sel);
    }

    /**
     * First time online count by month and network
     *
     * @return Zend_Db_Table_Rowset
     */
    public function getTotalActiveByMonthByNetwork($year, $network)
    {
        $sel = $this->select()->from($this->_name, new Zend_Db_Expr("count(macaddr) as t,
            DATE_FORMAT(first_online, '%m') as first_online")
                );

        $network = addslashes($network);

        $sel->where("DATE_FORMAT(first_online, \"%Y\") = ? ", $year)
                ->where("SUBSTR(lastip, 1, 4) = ? ", $network)
                ->group("DATE_FORMAT(first_online, '%Y-%m')");

        return $this->fetchAll($sel);
    }

    /**
     * Give a count distribution per node
     *
     * @return Array
     */
    public function getPerCellcount()
    {
        $sel = $this->select()->from($this->_name, new Zend_Db_Expr("node as node, count(macaddr) as t"));
        $sel->where("estado IN('activo')");
        $sel->group("node");

        return $this->fetchAll($sel);
    }
}
