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
 * Description of Docsismodem
 *
 * @author andref
 * @version $Id$
 */
class Client_Model_Client extends Zend_Db_Table_Row_Abstract
{

    /**
     *
     * @var DM__Model_Clients
     */
    protected $_table;
    
    protected $_data = array(
        'idclient' => ''
        ,'name'     => ''
        ,'contract' => ''
        ,'node'   => ''
        ,'state'   => ''
        ,'phone' => ''
        ,'mobile'=> ''
        ,'email'    => ''
    );
    
    /**
     *
     * @param Array|null $options 
     */
    public function __construct($options = array())
    {
        $this->_table = new Client_Model_Clients();
        parent::__construct($options);
    }
    
    public function cancel()
    {
        $this->state = 'unactive';
        $this->save();
    }
}

