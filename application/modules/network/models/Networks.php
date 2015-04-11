<?php

/**
 * Networks related storage control
 *
 * @author andref
 *
 */
class Network_Model_Networks extends Zend_Db_Table_Abstract
{

    protected $_name = 'config_nets';
    protected $_primary = 'netid';
    protected $_sequence = true;
    protected $_rowClass = 'Network_Model_Network';
    
}