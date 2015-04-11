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
 * Description of Pack
 *
 * @author andref
 * @copyright 2011 Fernando André < netriver at gmail.com > under license GPLv2
 */
class Client_Model_Pack extends Zend_Db_Table_Abstract
{
    protected $_name    = "pack";
    protected $_primary = "idpack";
    protected $_sequence = true;

    protected $dependentTables = array("service");

    protected $_referenceMap = array(
          "typeservice"   => array(
              "columns"         => "idtypeservice",
              "refTableClass"   => "Client_Model_Typeservice",
              "refColumns"      => "idtypeservice"
             )
    );

}
