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
 * Information regarding model and brand of a equipment / device
 *
 * @author andref
 * @version $Id$
 */
class DM_Model_Model extends Zend_Db_Table_Abstract {

    protected $_name        = 'model';
    protected $_primary     = 'idmodel';
    protected $_sequence    = true;
    protected $_rowClass    = 'Zend_Db_Table_Row';
    protected $_dependentTables = array("Brand");
    protected $_referenceMap    = array(
        'Brand' => array(
            'columns' => 'idbrand',
            'refTableClass' => 'DM_Model_Brand',
            'refColumns' => 'idbrand'
        )
    );

    public function getForcombo($idbrand) {
        $select = $this->select()
                ->from($this->_name, array('idmodel', 'description'))
                ->where("idbrand = " . (int) $idbrand);

        $stmt = $select->query();
        return $result = $stmt->fetchAll();
    }

    public function getAll($where = null )
    {
        $sel = $this->select()->from($this->_name, ["idmodel", "idbrand", "description", "vendormac"])->setIntegrityCheck(false)
                    ->joinLeft("brand", "model.idbrand=brand.idbrand",
                            new Zend_Db_Expr("name,
                                IFNULL(model.default_file, brand.default_file) as default_file,
                                IFNULL(model.default_file_phone_on, brand.default_file_phone_on) as default_file_phone_on,
                                IFNULL(model.default_file_mta, brand.default_file_mta) as default_file_mta,
                                IFNULL(model.onefilemta, brand.onefilemta) as onefilemta")
                            );

        if ( !empty($where)) {
            $sel->where($where);
        }
        $sel->order("model.description");

        $res = $this->fetchAll($sel);
        return $res;
    }

    public function newModel($modelname, $idbrand)
    {
        $values = array('description' => $modelname, 'idbrand' => $idbrand);
        if (($row = $this->fetchRow("description = '$modelname' AND idbrand = ". (int) $idbrand )) !== null  ) {
            return $row->idmodel;
        } else {
            $row = $this->insert($values);
            return $row;
        }
    }

    public function getCountModels()
    {
         // "select description, count(*) as t from model inner join docsismodem dm on (dm.idmodel = model.idmodel) group by model.idmodel order by t";
         $sel = $this->select()->from($this->_name,
                 array('description' => 'model.description'
                     , 't'          => new Zend_Db_Expr('COUNT(*)')
                     , 'brand'  => 'brand.name'
                     )
                 );

         $sel->setIntegrityCheck(false);
         $sel->joinInner("docsismodem", "docsismodem.idmodel = model.idmodel");
         $sel->joinInner("brand", "brand.idbrand = model.idbrand");
         $sel->group("idmodel");
         $sel->order("name");

         return $this->fetchAll($sel);
    }
}
