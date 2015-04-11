<?php

/**
 * Description of Static
 *
 * @author andref
 * @version $Id$
 */
class Network_Form_StaticNet extends Zend_Form
{
    public function __construct($options = null)
    {
        if (is_array($options) ) {
            if (array_key_exists("networks", $options)) {
                $this->setNetworks($options['networks']);
                unset($options['networks']);
            }
        }
        parent::__construct($options);
    }

    public function init()
    {
        $this->setMethod("post");
        $this->setName("staticnet");
        $this->setIsArray(true);
        $this->setAction("/networks/addstatic/");

        $ip = new Zend_Form_Element_Text("ipaddr");
        $ip->setLabel("Ip Address")
                ->setName("ipaddr");

        $mac = new Zend_Form_Element_Text("macaddr");
        $mac->setLabel("Mac Address")
                ->setName("macaddr");

        $subnum = new Zend_Form_Element_Select("subnum");
        $subnum->setOptions(array(
            'label' => 'Rede',
            'autocomplete' => false,
            'multiOptions' => $this->getNetworksToOption()
                )
        );

        $save = new Zend_Form_Element_Submit("Gravar");
        $save->setIgnore(true);

        $this->addElements(array($ip, $mac, $subnum, $save));

        //$subnum = new Zend_Form_Element_Select("subnum");
    }

    private $_networks = [];
    
    public function setNetworks($nets)
    {
        $this->_networks = $nets;
        return $this;
    }
    
    public function getNetworksToOption()
    {
        
        $Subnum = array(0 => '');
        foreach ($this->_networks as $net) {
            $Subnum[$net->netid] = $net->network . " " . $net->gateway;
        }

        return $Subnum;
    }

}
