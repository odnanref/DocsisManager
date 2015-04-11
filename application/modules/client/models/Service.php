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
 * Description of Service
 *
 * @author andref
 * @version $Id$
 */
class Client_Model_Service extends Zend_Db_Table_Row_Abstract
{
    /**
     *
     * @var DM_Model_Services
     */
    protected $_table;
    /**
     *
     * @var Array $_data campos
     */
    protected $_data = array(
        'idservice'     => -1
        ,'idequipment'  => ""
        ,'idpack'       => ""
        ,'dataactive'   => ""
        ,'dataunactive' => ""
        ,'tel'          => ""
    );
    
    public function __construct(array $config = array())
    {
        $this->_table = new Client_Model_Services();
        parent::__construct($config);
    }

    protected function _insert()
    {
        $this->dataactive = date("Y-m-d H:i:s");
    }
    
    public function getNetworkSpeed()
    {
        if ($this->idequipment <= 0 ) {
            return null;
        }
        
        $sel = $this->select()->from("service", array());
        $sel->columns(
                new Zend_Db_Expr("REPLACE(pack.prebuilt_file_mta, \"#BRAND#\", brand.code) as prebuilt_file_mta")
                );
        $sel->setIntegrityCheck(false);
        $sel->joinInner("equipment", "service.idequipment = equipment.idequipment", array());
        $sel->joinInner("model", "model.idmodel = equipment.idmodel");
        $sel->joinInner("brand", "brand.idbrand = model.idbrand");
        $sel->joinInner("pack", "pack.idpack = service.idpack ");
        $sel->joinInner("typeservice", "typeservice.idtypeservice = pack.idtypeservice ", array());
        $sel->where("typeservice.type = 'net' ");
        $sel->where("equipment.idequipment = " . (int) $this->idequipment);

        $a = $this->_table->getAdapter()->query($sel);
        $a = $a->fetchObject();

        if (!$a)
            return null;
        
        return array( "down" => $a->downloadspeed, "up" => $a->uploadspeed,
            "prebuilt" => $a->prebuilt_file, 
            "prebuilt_mta" => $a->prebuilt_file_mta
                );
    }
    
}
