<?php

/**
 * Description of StaticNet
 *
 * @author andref
 */
class  Network_Model_StaticNet extends Zend_Db_Table_Abstract
{
    protected $_name = 'cust_static';
    protected $_primary = 'ipaddr';
    protected $_sequence = false;
    //protected $_rowClass = 'DM_Model_Network';
    
    protected $_referenceMap = array(
        "config_nets" => array(
            "columns" => "netid",
            "refTableClass" => "Network_Model_Networks",
            "refColumns" => "subnum"
        )
    );
    
    public function GetAllDetails()
    {
        $sel = $this->select()->from($this->_name)->setIntegrityCheck(false);
        $sel->joinInner("config_nets", "config_nets.netid = cust_static.subnum ", array('network', 'gateway', 'cmts_ip'));
        return $this->fetchAll($sel);
    }
    
}
