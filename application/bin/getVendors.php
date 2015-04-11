#!/usr/local/bin/php -q
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
 * Get Modem information from the network
 * 
 * @author andref
 * @version $Id$
 */

require 'Zend/Loader/Autoloader.php';
$loader = Zend_Loader_Autoloader::getInstance();

// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH',
              realpath(dirname(__FILE__) . '/../'));

$app = new Zend_Application("production", "../configs/application.ini");
$loader = $app->getAutoloader();
$app->bootstrap();

$dm     = new DM_Model_Docsismodems();
$brand  = new DM_Model_Brand();
$model  = new DM_Model_Model();

foreach ( $dm->getActivos() as $activo ) {
    print $activo->macaddr . " = ". var_export($activo->idmodel, true) ."\n";
    if ( $activo->idmodel != 4 && !empty($activo->idmodel)) {
        continue;
    }
    print "running on ".$activo->macaddr . PHP_EOL ;
    $snmp = $activo->remoteQuery();
    $details = $activo->getremoteDetailInfo();
    if (empty($details['VENDOR'])) {
        $details['VENDOR'] = 'MISSING_INFO';
        $details['MODEL'] = 'MISSING_INFO';
        if ($activo->idmodel == 4 ) {
            continue;
        }
    }

    if ($snmp !== null && $details !== null) {
        $idbrand = $brand->newBrand($details['VENDOR']);
        if ($idbrand <= 0 ) {
            throw new Exception("FAILED inserting new brand");
        }
        $idmodel = $model->newModel($details['MODEL'], $idbrand);
        if ($idmodel > 0 ) {
            $activo->idmodel = $idmodel;
            $activo->save();
        }
        print "\tVendor: " . $details['VENDOR'] . " Model:" . $details['MODEL'] .
                " : " . $activo->idmodel ."\n"; 
    }
}

