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

define("DOCSIS_CFG_OUTPUT_DIR", APPLICATION_PATH . "/../gen/", true);

/**
 * Description of GenCMFile
 *
 * To generate a config file for a specific cable modem
 *
 * requires docsis tool
 *
 * @author andref
 * @version $Id$
 */
class Far_Docsis_GenCMFile
{
    /**
     *
     * Output msg's
     *
     * @var Array
     */
    private $Output = array();

    /**
     * Get the output of docsis tool execution
     *
     * @return array
     */

    public function getOutput()
    {
        return $this->Output;
    }

    protected $key;

    public function setKey($k)
    {
        $this->key = $k;
    }

    protected $file_out = 'speed';

    protected $files = array();

    public function setFileOut($val, $type = 'cm')
    {
        $this->files[$type] = $val;
        $this->file_out = $val;
        return $this;
    }

    public function getFileOut($type = 'cm')
    {
        if (!array_key_exists($type, $this->files)) {
            return null;
        }
        return $this->files[$type];
    }

    /**
     * Macaddr of CM
     * @var string
     */
    protected $macaddr;

    /**
     * specify macaddr
     *
     * @param string $val
     */

    public function setMacAddr($val)
    {
        $this->macaddr = $val;
    }

    public function getMacAddr()
    {
        return $this->macaddr;
    }

    protected $_configPath = "";

    public function setConfigPath($cfg)
    {
        $this->_configPath = $cfg;
        return $this;
    }

    public function getConfigPath()
    {
        return $this->_configPath;
    }

    /**
     * Olds community for configuration access for version of snmp
     * access type
     *
     * Only version 1 implemented
     *
     * @var Array
     */
    protected $SnmpConfig = array();

    public function setSnmpRead( $comm , $version = 1)
    {
        $this->SnmpConfig["read"][$version] = $comm;
        return $this;
    }

    public function getSnmpRead($version = 1)
    {
        if (!array_key_exists("read", $this->SnmpConfig)) {
            return null;
        }

        if (!array_key_exists($version, $this->SnmpConfig["read"])) {
            throw new Exception("No configuration for $version in getSnmpRead.");
        }

        return $this->SnmpConfig["read"][$version];
    }

    public function setSnmpWrite( $comm , $version = 1)
    {
        $this->SnmpConfig["write"][$version] = $comm;
        return $this;
    }

    public function getSnmpWrite($version = 1)
    {
        if (!array_key_exists("write", $this->SnmpConfig)) {
            return null;
        }

        if (!array_key_exists($version, $this->SnmpConfig["write"])) {
            throw new Exception("No configuration for $version in getSnmpWrite.");
        }

        return $this->SnmpConfig["write"][$version];
    }

    /**
     * Voip server configuration for EMTA
     *
     * @var Array
     */
    protected $voipServers = array();
    /**
     * Add Voip servers IP Address
     *
     * At the moment this does not override the server port
     *
     * @param array $list
     */
    public function addVoipServers(array $list)
    {
        foreach ($list as $server) {
            $this->addVoipServer($server[0]);
        }
    }

    public function addVoipServer($ip, $port = 5060)
    {
        $host = array();
        $host["ip"] = $ip;
        $host["port"] = $port;
        $this->voipServers[] = $host;

        return $this;
    }

    public function getVoipServers()
    {
        if (count($this->voipServers) > 0 ) {
            return $this->voipServers;
        }
        throw new Exception("Voip servers not specified in configuration.");
    }

    public function clearVoipServers()
    {
        $this->voipServers = array();
        return $this;
    }

    protected $swupgradeserver = null;

    public function setSWUpgradeServer($ip)
    {
        $this->swupgradeserver = $ip;
        return $this;
    }

    public function getSWUpgradeServer()
    {
        if ($this->swupgradeserver === null) {
            throw new Exception("SW Upgrade server not known.");
        }
        return $this->swupgradeserver;
    }


    protected $upload;

    /**
     * Specify upload speed
     *
     * @param string|int $val
     */

    public function setUpload($val)
    {
        if (strtoupper(substr($val, -1)) == "M") {
            $val = substr($val, 0, strlen($val)-1);
            $val = $val*1000*1000;
        }
        elseif (strtoupper(substr($val, -1)) == "K") {
            $val = substr($val, 0, strlen($val)-1);
            $val = $val*1000;
        }
        $this->upload = $val;
    }

    protected $download;
    /**
     * specify download speed
     *
     * @param string|int $val
     */

    public function setDownload($val)
    {
        if (strtoupper(substr($val, -1)) == "M") {
            $val = substr($val, 0, strlen($val)-1);
            $val = $val*1000*1000;
        }
        elseif (strtoupper(substr($val, -1)) == "K") {
            $val = substr($val, 0, strlen($val)-1);
            $val = $val*1000;
        }
        $this->download = $val;
    }

    /**
     * Only one file for CM and EMTA
     *
     * @var boolean
     */
    private $onefilemta = false;

    public function setOneFileMta($flag)
    {
        $this->onefilemta = (boolean)$flag;
    }

    public function isOneFileMta()
    {
        return $this->onefilemta;
    }

    private $onlyMta = false;

    public function setOnlyMta($flag)
    {
        $this->onlyMta = (boolean) $flag;
    }

    public function onlyMta()
    {
        return $this->onlyMta;
    }

    /**
     * MTA Mac
     *
     * @var string
     */
    protected $macaddr_mta;

    /**
     * specify mta mac
     *
     * @param string $mac
     */
    public function setMacMta($mac)
    {
        $this->macaddr_mta = $mac;
    }

    /**
     * Total phone lines
     *
     * @var array
     */

    protected $tel = array();

    /**
     * Specify phone number and phone line
     *
     * @param string $tel1
     * @param int $line
     * @throws OutOfBoundsException case line not int (1,2)
     */
    public function setPhone($tel1, $line)
    {
        if (!in_array($line, array(1,2))) {
            throw new OutOfBoundsException("The value placed is not inside the limits.");
        }
        $this->tel[$line] = $tel1;
    }

    public function getPhoneByLine($line)
    {
        if (array_key_exists($line, $this->tel)) {
            return $this->tel[$line];
        }
        return null;
    }

    public function getLineByNumber($teln)
    {
        foreach ($this->tel as $key => $num ) {
            if ($num == $teln) {
                return $key;
            }
        }
        return null;
    }

    private $PhoneAuthData = array();

    public function setLineAuth($line, $login, $pass, $number)
    {
        $this->PhoneAuthData[$line]["login"] = $login;
        $this->PhoneAuthData[$line]["pass"] = $pass;
        $this->PhoneAuthData[$line]["number"] = $number;

        return $this;
    }

    public function getLineAuth($line)
    {
        if (array_key_exists($line, $this->PhoneAuthData)) {
            return $this->PhoneAuthData[$line];
        }
        return null;
    }

    public function hasMtaConfigured()
    {
        return ( trim($this->getPhoneByLine(1)) != '' ||
                trim($this->getPhoneByLine(2)) != '' );
    }

    /**
     * Example file to be used for CM
     *
     * @var string
     */
    protected $default_file;

    public function setDefaultCMFile($file)
    {
        $this->default_file = $file;
        return $this;
    }

    public function getDefaultCMFile()
    {
        return $this->getConfigPath() . $this->default_file;
    }

    protected $default_file_phone_on;

    public function setDefaultCMFilePhoneOn($file)
    {
        $this->default_file_phone_on = $file;
        return $this;
    }

    public function getDefaultCMFilePhoneOn()
    {
        return $this->getConfigPath() . $this->default_file_phone_on;
    }

    /**
     * Example file to be used for MTA config
     *
     * @var string
     */
    protected $default_file_mta = null;

    public function setDefaultMtaFile($file)
    {
        $this->default_file_mta = $file;
        return $this;
    }

    public function getDefaultMtaFile()
    {
        return $this->getConfigPath() . $this->default_file_mta;
    }

    protected $default_file_mta_2l = null;

    public function setDefaultMtaFile2L($file)
    {
        $this->default_file_mta_2l = $file;
        return $this;
    }

    public function getDefaultMtaFile2L()
    {
        return $this->getConfigPath() . $this->default_file_mta_2l;
    }

    private $idmodel;

    public function setIdModel($id)
    {
        $this->idmodel = $id;
        return $this;
    }

    public function getIdModel()
    {
        return $this->idmodel;
    }
    /**
     * Ready to use cm config
     * @var string
     */
    private $file_cfg;

    private function genDefault()
    {
        $this->preGenDefault();

        // add the .bin to the file suffix
        $this->setFileOut($this->getFileOut() . ".bin");

        return $this->makeFile();
    }

    /**
     * ready to use mta config
     *
     * @var string
     */
    private $file_mta_cfg;

    private function genMta()
    {
        $this->setIsMta(true);
        $this->preGenDefaultMTA();

        $file = $this->getFileOut() . "_mta.bin";

        $this->setFileOut($file, 'mta');
        return $this->makeFile('mta');
    }

    public function generate()
    {
        if (count($this->files) <= 0) {
            throw new Exception("No default files in place");
        }

        if (empty($this->macaddr)) {
            throw new Exception("Empty macaddr ");
        }

        if ($this->hasMtaConfigured()) {

            $this->genMta();

            if ($this->onlyMta() === true || $this->isOneFileMta() === true ) {
                return true;
            } else {
                $fileh = ( $this->download."_".$this->upload . "_" .
                        $this->getIdModel() );
                $this->setFileOut( $fileh );
            }
        }
        $tmpab = $this->getFileOut();
        if (empty($tmpab)) {
            $fileh = ( $this->download."_".$this->upload . "_" .
                        $this->getIdModel() );
            $this->setFileOut( $fileh );
        }

        $this->genDefault();

        return true;
    }

    public function preGenDefault()
    {
        $tmp = "";
        if ($this->hasMtaConfigured()) {
            $tmp = file_get_contents($this->getDefaultCMFilePhoneOn());
        } else {
            $tmp = file_get_contents($this->getDefaultCMFile());
        }

        $server = $this->getVoipServers();

        $tmp = str_replace("#MAXUP#", $this->upload, $tmp);
        $tmp = str_replace("#MAXDOWN#", $this->download, $tmp);

        $tmp = str_replace("#SNMP-READ#", $this->getSnmpRead(), $tmp);
        $tmp = str_replace("#SNMP-WRITE#", $this->getSnmpWrite(), $tmp);
        $tmp = str_replace("#VOIP-SERVER-IP-1#", $server[0]["ip"], $tmp);
        $tmp = str_replace("#SW-UPGRADE-SERVER#", $this->getSWUpgradeServer(), $tmp);

        if ( count($this->tel) > 0 )  {
            $c = count($this->tel);
            for($i=1; $i <= $c ; $i++ ) {
                $tmp = str_replace("#NUMEROTELF-" . $i . "#", $this->tel[$i], $tmp);
                $tmp = str_replace("#NUMEROTELF-" . $i . "NUMBER#", $this->PhoneAuthData[$i]["number"], $tmp);
                $tmp = str_replace("#NUMEROTELF-" . $i . "LOGIN#", $this->PhoneAuthData[$i]["login"], $tmp);
                $tmp = str_replace("#NUMEROTELF-" . $i . "PASS#", $this->PhoneAuthData[$i]["pass"], $tmp);
            }
        }

        $this->file_cfg = $tmp;
    }

    public function preGenDefaultMTA()
    {
        if (count($this->tel) > 1 ) {
            $tmp = file_get_contents($this->getDefaultMtaFile2L());
        } else {
            $tmp = file_get_contents($this->getDefaultMtaFile());
        }

        $server = $this->getVoipServers();

        $tmp = str_replace("#MAXUP#", $this->upload, $tmp);
        $tmp = str_replace("#MAXDOWN#", $this->download, $tmp);
        $tmp = str_replace("#SNMP-READ#", $this->getSnmpRead(), $tmp);
        $tmp = str_replace("#SNMP-WRITE#", $this->getSnmpWrite(), $tmp);
        $tmp = str_replace("#VOIP-SERVER-IP-1#", $server[0]["ip"], $tmp);
        $tmp = str_replace("#SW-UPGRADE-SERVER#", $this->getSWUpgradeServer(), $tmp);

        if ( count($this->tel) > 0 )  {
            $c = count($this->tel);
            for($i=1; $i <= $c ; $i++ ) {
                $tmp = str_replace("#NUMEROTELF-" . $i . "#", $this->tel[$i], $tmp);
                $tmp = str_replace("#NUMEROTELF-" . $i . "NUMBER#", $this->PhoneAuthData[$i]["number"], $tmp);
                $tmp = str_replace("#NUMEROTELF-" . $i . "LOGIN#", $this->PhoneAuthData[$i]["login"], $tmp);
                $tmp = str_replace("#NUMEROTELF-" . $i . "PASS#", $this->PhoneAuthData[$i]["pass"], $tmp);
            }
        }

        $this->file_mta_cfg = $tmp;
        $this->setIsMta(true);
    }

    /**
     * Keeps the state of generation
     *
     * null if no attempt was done to generate it
     *
     * @var bool|null
     */
    private $failgen = null;

    /**
     * Specify if there was a failure generating the fail
     * @param bool $flag
     */

    private function setFailGen($flag)
    {
        if ($this->failgen === false ) {
            return false;
        }
        $this->failgen = $flag;
    }

    /**
     * Returns true if file was generated
     *
     * @return boolean
     */
    public function isSuccess()
    {
        if (($this->failgen) === null ) {
            throw new Exception("No attempt was done to generate the file.");
        }
        return ($this->failgen === true ? false : true);
    }

    protected $isMta = false;

    private function setIsMta($flag)
    {
        $this->isMta = (boolean) $flag;
    }

    public function isMta()
    {
        return $this->isMta;
    }
    /**
     *
     * @param string $type mta|cm
     * @throws Exception
     */
    private function makeFile($type = 'cm')
    {
        $outmsg = '';
        $dest_file = DOCSIS_CFG_OUTPUT_DIR . $this->getFileOut($type);

        if (!is_dir(dirname($dest_file))) {
            throw new Exception("Directory $dest_file does not exist.");
        }

        if (!is_writable(dirname($dest_file)) ) {
            throw new Exception("Unable to write file " . $dest_file);
        }

        if ($type == 'cm') {
            $outmsg = $this->file_cfg;
            $tmp_file = "/tmp/temp_".$this->macaddr.".cfg";
        } elseif($type == 'mta') {
            $outmsg = $this->file_mta_cfg;
            $tmp_file = "/tmp/temp_".$this->macaddr."_mta.cfg";
        }

        $fp = fopen($tmp_file, "a+");
        if ($fp) {
            fwrite($fp, $outmsg);
            fclose($fp);
        }

        if (empty($this->key)) {
            $key = $tmp_file;
        }

        $tool = "/usr/bin/docsis";
        if (!is_executable($tool)) {
            if (!is_executable("/usr/local/bin/docsis")) {
                throw new Exception("Docsis tool not executable or found.");
            } else {
                $tool = "/usr/local/bin/docsis";
            }
        }

        $ex = "$tool -e $tmp_file $key $dest_file";
        ob_start();
        exec($ex, $this->Output);
        $this->Output[] = ob_get_clean();

        if (!unlink($tmp_file)) {
            throw new Exception("Unable to delete file $tmp_file");
        }

        if (!is_readable($dest_file)) {
            $this->setFailGen(true);
        } else {
            $this->setFailGen(false);
        }
    }

    public function __construct()
    {

    }
}
