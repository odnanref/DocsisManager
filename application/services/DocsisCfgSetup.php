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
 * DocsisCfgSetup Construct the CM file
 * 
 * Requires Docsis gen file
 * 
 * @author andref
 * @version $Id$
 */
class DM_Service_DocsisCfgSetup
{
    private $Data = array();
    
    public function getData($name)
    {
        if (!array_key_exists($name, $this->Data)) {
            return null;
        }
        
        return $this->Data[$name];
    }
    
    public function __construct($options = array())
    {
        if (is_array($options) && count($options) > 0 ) {
            $this->Data = array_merge($options, $this->Data);
        }
    }
    
    public function init()
    {
        $pack       = $this->getData("pack");
        $hasnet     = $this->getData("hasnet");
        $hasphone   = $this->getData("hasphone");
        $modem      = $this->getData("modem");
        
        $genfile    = false;
        
        $filename   = $pack->prebuilt_file;
                
        if ( $hasnet === true && $hasphone === true ) {
            // has both services
            $speedup    = $pack->uploadspeed;
            $speeddown  = $pack->downloadspeed;
            
            if ($onefilemta === true) {
                $genfile = true;
            } else {
                if (!empty($pack->prebuilt_file_mta)) {
                    // ALREADY REPLACED #IDMODEL# by idmodel
                    $filename = $pack->prebuilt_file_mta;
                }
            }

        } elseif ($hasnet === true && !$hasphone ) {
            // has internet
            $speedup    = $pack->uploadspeed;
            $speeddown  = $pack->downloadspeed;
            
            if ( empty($pack->prebuilt_file) ) {
                $genfile = true;
            } else {
                $filename = $pack->prebuilt_file;
            }
            
        } elseif (!$hasnet && $hasphone ) {
            // has only phone
            $speedup    = 0;
            $speeddown  = 0;
            
            if ($onefilemta === true || empty($pack->prebuilt_file) ) {
                $genfile = true;
            } else {
                if (!empty ($pack->prebuilt_file_mta)) {
                    $filename = $pack->prebuilt_file_mta;
                }
            }
        }
        
        $dms    = new DM_Model_Docsismodems();
        $cm = $dms->getById($modem->macaddr);
        
        if ($cm === null ) {
            throw new Exception("No relation between docsismodem and equipment");
        }
        
        if (!empty($Service->tel)) {
            $tmp = "tel" . $Service->linenumber;
            $cm->{$tmp} = $Service->tel;
        } else {
            $cm->tel1 = null;
            $cm->tel2 = null;
        }
        
        $bool = null;
        
        if ($genfile === true ) {
            $bool   = $dms->genFile($modem->macaddr, $speedup, $speeddown, $filename);
        }
        
        if ($hasphone === true && $genfile === false ) {
            $bool   = $dms->genMtaFile($modem->macaddr, $speedup, $speeddown, $filename); // FIXME
        }
        
        if ($bool === false) {
            return false;
        } else {
            if ($bool === null ) {
                $cm->config_file = $filename;
            }
            $cm->estado = 'activo';
            if ($cm->save()) {
                return true;
            }
        }
    }
}
