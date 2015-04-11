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

$pdo = new PDO(
    'mysql:host=stv;dbname=dhcp',
    'user',
    'pppp'
);
$currentm = date("Ymd");

$pdo->exec("CREATE TABLE IF NOT EXISTS counter".$currentm." (idcounter int auto_increment, datain timestamp, macaddr varchar(12) not null, traffic BIGINT UNSIGNED, PRIMARY KEY(idcounter))");

$sql = "SELECT lastip as ipaddr, macaddr FROM docsismodem WHERE estado = 'activo' AND config_file NOT LIKE '%desligado%'";

$pdo->beginTransaction();
$sth = $pdo->prepare($sql);
$sth->execute();
//$modems = $sth->fetchAll(PDO::FETCH_CLASS);

function getTraffic($ip)
{
    $tmp = explode(":", snmpget($ip, "public", ".1.3.6.1.2.1.2.2.1.10.1"));
    if (!array($tmp)) {
        $tmp[0] = '';
        $tmp[1] = 0;
    }
    return trim($tmp[1]);
}

foreach ( $sth->fetchAll(PDO::FETCH_CLASS) as $modem ) {
  $ip   = str_replace("0.0.", "10.1.", $modem->ipaddr);
  $cur  = getTraffic($ip);
  print "Modem:".$modem->macaddr." ".$cur.PHP_EOL;
  if ($cur > 0 ) {
    $sth2 = $pdo->prepare("SELECT macaddr, traffic FROM counter".$currentm." WHERE macaddr = ? ");
    $sth2->execute(array($modem->macaddr));
    if (trim($modem->macaddr) == '' ) {
        continue;
    }
    $cmodem = $sth2->fetch(PDO::FETCH_OBJ);
    $cmodem = false;
    if (!$cmodem) {
        $insert = $pdo->prepare("INSERT INTO counter".$currentm." (macaddr, traffic, datain) VALUES (?, ?, ?)");
        $insert->execute(array($modem->macaddr, $cur, date("Y-m-d H:i:s")));
        print "\tA inserir\n";
    } else {
        if ($cur > $cmodem->traffic ) {
            $traf = $cur-$cmodem->traffic;
        } else {
            $traf = $cmodem->traffic-$cur;
        }
        $update = $pdo->prepare("UPDATE counter".$currentm." SET traffic=traffic+(traffic-?) WHERE macaddr = ? ");
        $update->execute(array($traf, $modem->macaddr));
        print "\tA actualizar\n";
    }
  }
}
