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
 * Description of Omapi
 * Class to communicate to the omapi api of the dhcpd isc server
 * and place orders.
 *
 * @author kwesibrunee url: <http://docsis.org/node/301>
 * @author andref <netriver@gmail.com> Changed the format to be more OOP
 * 
 */
class Far_Dhcp_Omapi {

    public $key = "";
    public $server = "";
    public $Port = 9991;
    public $omshellPath = "/usr/bin/omshell";
    private $process;
    private $pipes;
    private $connected = false;

    public function __construct() {
        $this->connect();
    }

    public function connect() {
        $dspec = array(
            0 => array("pipe", "r"),
            1 => array("pipe", "w"),
            2 => array("file", "/tmp/eo.txt", "a")
        );

        $success = array();
        $success[0] = false;
        $success[1] = "";
        $this->process = proc_open($this->omshellPath, $dspec, $this->pipes);

        if (is_resource($this->process)) {
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "port " . $this->Port);
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "key omapi_key \"" . $this->key . "\"");
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "server " . $this->server);
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "connect");
            $connected = $this->readit($this->pipes);
            if ($connected == "obj: <null>\n> ") {
                $this->connected = true;
            } else {
                print "failed\n";
                return false;
            }
        }
    }

    public function __destruct() {
        fclose($this->pipes[0]);
        fclose($this->pipes[1]);
        proc_close($this->process);
    }

    function readit($pipes, $end = '> ', $length = 1024) {
        $returnValue = "";
        stream_set_blocking($pipes[1], FALSE);
        while (!feof($pipes[1])) {
            $buffer = fgets($pipes[1], $length);
            $returnValue .= $buffer;
            if (substr_count($buffer, $end) > 0) {
                $pipes[1] = "";
                break;
            }
        }
        return $returnValue;
    }

    function writeit($pipes, $str) {
        fwrite($pipes[0], "$str\n");
        return "$str\n";
    }

    /**
     * @deprecated use addHost
     * 
     * @param type $macAddress
     * @param type $group
     * @return type 
     */
    public function addCM($macAddress, $group) {
        $success = array();
        $success[0] = false;
        $success[1] = "";

        if (is_resource($this->process) && $this->connected) {
            $this->writeit($this->pipes, "new host");
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "set known=1");
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "set hardware-type=1");
            $this->readit($this->pipes);
            $formatted_mac = ereg_replace(":$", "", chunk_split($macAddress, 2, ":"));
            $this->writeit($this->pipes, "set hardware-address=$formatted_mac");
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "set group=\"$group\"");
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "create");
            $added = $this->readit($this->pipes);
            if (ereg("^obj: host", $added) || ereg("open object: already exists", $added)) {
                $success[0] = true;
            } else {
                $success[1] = $added;
            }
        }
        return $success;
    }

    public function addHost(Far_Dhcp_Omapihost $host) {
        $success = array();
        $success[0] = false;
        $success[1] = "";

        if (is_resource($this->process) && $this->connected) {
            $this->writeit($this->pipes, "new host");
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "set known=" . $host->known);
            $this->readit($this->pipes);
            $this->writeit($this->pipes, "set hardware-type=" . $host->hardwaretype);
            $this->readit($this->pipes);
            $formatted_mac = ereg_replace(":$", "", chunk_split($host->hardwareaddress, 2, ":"));
            $this->writeit($this->pipes, "set hardware-address=$formatted_mac");
            $this->readit($this->pipes);
            foreach ($host->getOptions() as $ke => $va) {
                $this->writeit($this->pipes, "set $ke=\"$va\"");
                $this->readit($this->pipes);
            }

            $this->writeit($this->pipes, "create");
            $added = $this->readit($this->pipes);
            if (ereg("^obj: host", $added) || ereg("open object: already exists", $added)) {
                $this->writeit($this->pipes, "remove");
                $success[0] = true;
            } else {
                $success[1] = $added;
            }
        }
        return $success;
    }

}

$omapi = new Far_Dhcp_Omapi();
$omapi->server = "s3";
$omapi->key = "SIjfzginL2U8m+qjriTN6qw8rPBm6Q==";
$omapi->connect();

$result = $omapi->addCM("001122334455", "4MEGA");
// if successful
if ($result[0] == true) {
    echo "successful";
} else {
// if not successful do something with error message
    echo $result[1];
}