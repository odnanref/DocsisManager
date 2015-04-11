<?php
/**
 * IP Calculation Class
 *
 * @author Benjamin Zeiss <hide@address.com>
 * @version 0.55
 * @package ipcalc
 *
 * $Id: class.ipcalc.php,v 1.3 2002/09/18 21:12:33 bzeiss Exp $
 *
 * Description:
 * This class helps php applications with ip calculation methods. It may
 * be most interesting for applications that should act differently depending
 * on in which subnet the computer is part of. 
 *
 * Example:
 *
 * You have a kickass news script running in your company intranet. In this
 * company there are different teams. Now, you want to put different news into the 
 * system for each team. These news articles should be displayed only to the according
 * team members and not the other teams.
 * Usually this kind of access control in done with a user/password authentication
 * or apache password protection. In some cases however, it may be smart to implement
 * such functionaly directly into the script to have greater control over everything
 * and to to make things easier when security is not much of an issue (ip's can be
 * faked of course).
 *
 * The script can of course also be used to make the access control more tight as well !
 * You may, for example, want users with username's/password's to access some script
 * parts, but only when they are member of a certrain subnet.
 *
 * To sum it up: there are many places where this class could be used to enhance 
 * comfort and/or security in intranet aware php applications.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

namespace Bzeiss;

class IpCalc
{ 

    // ====================================================================================
    // Private Variable Definitions
    // ====================================================================================
    private $_networkaddress; // integer array with 4 elements
    private $_subnetmask; // integer array with 4 elements
    private $_error; // array: 1st element boolean flag ('flag'), 2nd element errorstring ('string')
    private $_debug; // true or false
    
    /**
     ** Constructor
     **/
    public function __construct()
    {
        $this->_debug = 0;
        $this->_error[0] = $this->_error['flag'] = false;
    }

    // ====================================================================================
    // Public functions
    // ====================================================================================

    /**
     * Network Address modifier
     *
     * @param string network ip address
     * @returns true if successful, false if unsuccessful
     */
    public function setNetworkAddress($ip)
    {
        if (($this->_networkaddress = $this->_destringifyIP($ip)) == false)
            return false;

        return true;
    }

    /**
     * Subnetmask modifier
     *
     * @param string subnetmask. accepts either dotted or numeric mask
     * @returns true if successful, false if unsuccessful
     */
    public function setSubnetmask($ip)
    {
        if (($this->_subnetmask = $this->_destringifyIP($ip,false)) == false) {
        // ip is not in dotted form, try numeric
            if (($ip >=0) && ($ip <= 32)) {
                $i=0;
                $bit=0;
                $n=0;
                $this->_subnetmask[0]="";
                $this->_subnetmask[1]="";
                $this->_subnetmask[2]="";
                $this->_subnetmask[3]="";
                while ($i < $ip) { // convert to binary ip array
                    $this->_subnetmask[$n].="1";
                    $i++;
                    $bit = $i % 8;
                    if ($bit == 0) {
                        $n++;
                    }
                }               
                // convert binary parts to decimal parts
                $this->_subnetmask[0]=bindec($this->_subnetmask[0]);
                $this->_subnetmask[1]=bindec($this->_subnetmask[1]);
                $this->_subnetmask[2]=bindec($this->_subnetmask[2]);
                $this->_subnetmask[3]=bindec($this->_subnetmask[3]);
                return true;
            }

            return false;           
        }
            
        return true;
    }
    
    /**
     * gets the current network address as string
     *
     * @returns ip address as string
     */
    public function getNetworkAddress()
    {
        return $this->_stringifyIP($this->_networkaddress);
    }

    /**
     * gets the current subnet as string
     *
     * @returns subnet as string
     */
    public function getSubnetmask()
    {
        return $this->_stringifyIP($this->_subnetmask);
    }

    /**
     * get first host in subnet
     *
     * @return ip address of the first host in the subnet, false on error
     */
    public function getFirstHost()
    {
        if (!isset($this->_networkaddress) || !isset($this->_subnetmask)) {
            $this->_setError(true,"Network not properly set");
            $this->_outputError();
            return false;
        }
        
        $ip_address = $this->_destringifyIP($this->getNetworkAddress());
        $ip_address[3]+=1;
        return $this->_stringifyIP($ip_address);
    }

    /**
     * get last host in subnet
     *
     * @returns ip address of the last host in the subnet, false on error
     */
    public function getLastHost()
    {
        if (!isset($this->_networkaddress) || !isset($this->_subnetmask)) {
            $this->_setError(true,"Network not properly set");
            $this->_outputError();
            return false;
        }

        $ip_address = $this->_destringifyIP($this->getBroadcast());
        $ip_address[3]-=1;
        return $this->_stringifyIP($ip_address);
    }

    /**
     * get broadcast address in subnet
     *
     * @returns the subnet's broadcast address, false on error
     */
    public function getBroadcast()
    {
        if (!isset($this->_networkaddress) || !isset($this->_subnetmask)) {
            $this->_setError(true,"Network not properly set");
            $this->_outputError();
            return false;
        }

        $inverse_subnet = $this->_invertIP($this->_subnetmask);
        $broadcast[0] = intval($this->_networkaddress[0]) | intval($inverse_subnet[0]);
        $broadcast[1] = intval($this->_networkaddress[1]) | intval($inverse_subnet[1]);
        $broadcast[2] = intval($this->_networkaddress[2]) | intval($inverse_subnet[2]);
        $broadcast[3] = intval($this->_networkaddress[3]) | intval($inverse_subnet[3]);

        return $this->_stringifyIP($broadcast);
    }

    /**
     * checks whether a given IP Address is within the subnet
     * which has been set before
     *
     * @param string ip address to check
     * @returns true if ip is within the subnet, false otherwise
     */
    public function isIPInSubnet($ip)
    {
        if (!isset($this->_networkaddress) || !isset($this->_subnetmask)) {
            $this->_setError(true,"Network not properly set");
            $this->_outputError();
            return false;
        }

        $network = $this->calculateNetworkAddress($ip,$this->getSubnetmask());
        if (strcmp($network,$this->getNetworkAddress()) == 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * gets all possible ip addresses within the set subnet in one array
     *
     * @returns array with all possible ip addresses, false on error
     */
    public function getPossibleIPAddresses()
    {
        if (!isset($this->_networkaddress) || !isset($this->_subnetmask)) {
            $this->_setError(true,"Network not properly set");
            $this->_outputError();
            return false;
        }
        
        $current_host = $this->getFirstHost();
        $last_host = $this->getLastHost();
        $i=0;

        while (strcmp($current_host,$this->getNextIP($last_host)) != 0) {
            $results[$i++]=$current_host;
            $current_host=$this->getNextIP($current_host);
        }
        
        return $results;
    }

    /**
     * takes an ip address as argument and returns the next one after
     * incrementation
     *
     * @param string ip address
     * @returns next ip (string), false on overflow
     */
    public function getNextIP($ip)
    {
        $current = $this->_destringifyIP($ip);
        $ip = (intval($current[0]) << 24) + (intval($current[1]) << 16) + 
              (intval($current[2]) << 8) + intval($current[3]) + 1;

        $current[0]= (intval($ip) & (255 << 24)) >> 24;
        $current[1]= (intval($ip) & (255 << 16)) >> 16;
        $current[2]= (intval($ip) & (255 << 8)) >> 8;
        $current[3]= (intval($ip) & 255);

        return $this->_stringifyIP($current);
    }


    /**
     * calculates the network address from given ip and subnetmask
     *
     * @param string ip address
     * @param string subnetmask
     * @returns the network address as string, false on error
     */
    public function calculateNetworkAddress($ip,$subnetmask)
    {
        if ( !($this->_isIP($ip)) ) {
            $this->_setError(true,"'".$ip."' is not an IP Address !");
            $this->_outputError();
            return false;
        } 
        if ( !($this->_isIP($subnetmask)) ) {
            $this->_setError(true,"'".$ip."' is not an IP Address !");
            $this->_outputError();
            return false;
        } 
        $ip_address = $this->_destringifyIP($ip);
        $sn_mask = $this->_destringifyIP($subnetmask);
        
        if (($ip_address || $sn_mask) == false) {
            return false;
        }
        
        $network_address[0] = intval($ip_address[0]) & intval($sn_mask[0]);
        $network_address[1] = intval($ip_address[1]) & intval($sn_mask[1]);
        $network_address[2] = intval($ip_address[2]) & intval($sn_mask[2]);
        $network_address[3] = intval($ip_address[3]) & intval($sn_mask[3]);

        return $this->_stringifyIP($network_address);
    }

    /**
     * get IP in dotted binary form
     *
     * @param string ip to display in dotted binary form
     * @returns ip address in binary numbers
     */
    public function getDottedBinary($ip)
    {
        $ip_address = $this->_destringifyIP($ip);
        $ip_address[0] = $this->_fillBinaryZeros(decbin($ip_address[0]));
        $ip_address[1] = $this->_fillBinaryZeros(decbin($ip_address[1]));
        $ip_address[2] = $this->_fillBinaryZeros(decbin($ip_address[2]));
        $ip_address[3] = $this->_fillBinaryZeros(decbin($ip_address[3]));

        return $this->_stringifyIP($ip_address);
    }

    /**
     * sets the debug level
     *
     * @param boolean debug level
     */
    public function setDebug($state)
    {
        $this->_debug = $state;
    }


    // ====================================================================================
    // Private functions
   // ====================================================================================

    /**
     * calculates the inverse of a given ip address (array).
     * ip address must be valid.
     *
     * @param array ip address to invert
     * @returns inverse ip address
     */
    private function _invertIP($ip)
    {
        $inverse[0] = intval($ip[0]) ^ intval(255);
        $inverse[1] = intval($ip[1]) ^ intval(255);
        $inverse[2] = intval($ip[2]) ^ intval(255);
        $inverse[3] = intval($ip[3]) ^ intval(255);

        return $inverse;
    }
    
    /**
     * checks a string if it is a ip address
     *
     * @param string ip address to check for validity
     * @return true if ip, false if not
     */
    private function _isIP($ip)
    {
        if (!preg_match("/^([\d]{1,3})\.([\d]{1,3})\.([\d]{1,3})\.([\d]{1,3})$/",$ip)) {
            return false;
        }
        $ip_array = explode(".",$ip);
        reset ($ip_array);
        while (list ($key, $val) = each ($ip_array)) {
            if (!$this->_isByte($val)) {
                return false;
            }
        }
        if (!(count($ip_array) == 4)) {
            return false;
        } 

        return true;
    }
    
    /**
     * Is a valid ip address
     * 
     * @param string $ip
     * @return boolean
     */
    public function isIp($ip)
    {
        return $this->_isIP($ip);
    }

    /**
     * checks whether the value of a number is within the Byte range
     *
     * @param int number to check
     * @returns true if byte, false if not a byte
     */
    private function _isByte($number)
    {
        if (($number >= 0) && ($number <= 255) ) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * prints a string if the debug flag is set
     *
     * @param string message to print
     */
    private function _printDebug($string) {
        if ($this->_debug) {
            printf($string);
        }
    }

    /**
     * converts an ip address to a dotted string
     *
     * @param array ip array to stringify
     * @returns ip string, false if ip is not valid
     */
    private function _stringifyIP($ip) {
        return sprintf("%s.%s.%s.%s",
            $ip[0],$ip[1],$ip[2],$ip[3]);
    }

    /**
     * converts an ip address string to the internal 
     * ip array structure.
     *
     * @param string ip array to destringify (string to array)
     * @param boolean prints error message if true (optional)
     * @returns ip string if successful, false if ip not valid
     */
    private function _destringifyIP($ip,$set_error=true) {
        if ( !($this->_isIP($ip)) ) {
            if ($set_error == true) {
                $this->_setError(true,"'".$ip."' is not an IP Address !");
                $this->_outputError();
            }
            return false;
        }
        return explode(".",$ip);
    }


    /**
     * sets the class error state
     *
     * @param boolean true if error, false if not
     * @param string errorstring (optional)
     */
    private function _setError($flag,$str="") {
        $this->_error[0] = $this->_error['flag'] = $flag;
        $this->_error[1] = $this->_error['string'] = "[Class IPCalc] ".$str;
    }

    /**
     * outputs the error string if debug is set
     */
    private function _outputError() {
        $this->_printDebug($this->_error['string']);
    }

    /**
     * takes a byte-size binary number as argument
     * and returns the same number, but filled with
     * zeros adjusted to the size of a byte
     *
     * @param byte binary number
     * @returns zero filled binary number
     */
    private function _fillBinaryZeros($number) {
        $zeros = "";
        for ($i=0; $i < 8-strlen($number); $i++) {
            $zeros.="0";
        }
        $number = sprintf("%s%s",$zeros,$number);
        return $number;
    }
    
}
