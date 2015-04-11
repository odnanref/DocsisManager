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
 * Description of Services
 *
 * @author andref
 * @version $Id$
 */
class Client_Form_Services extends Zend_Dojo_Form_SubForm
{

    /**
     * Available service types
     * 
     * @var array
     */
    public static $Availabletypes = array("phone", "internet", "tv");
    /**
     * type of service being active
     * 
     * @var string $type
     */
    private $type;

    public function getType()
    {
        return $this->type;
    }

    public function setType($type)
    {
        $this->type = $type;
        return $this;
    }

    private $idcliente = 0;

    public function getIdcliente()
    {
        return $this->idcliente;
    }

    public function setIdcliente($idcliente)
    {
        $this->idcliente = $idcliente;
    }

    private $servicosNet = array();
    private $servicosTelef = array();

    public function loadCombos()
    {
        if (count($this->servicosNet) > 0 && count($this->servicosTelef) > 0) {
            return null;
        }

        $netserv = new Client_Model_Typeservice();

        if ($this->type == 'internet') {
            $nets = $netserv->fetchRow("type = 'net' ");
            $this->servicosNet[0] = 'Sem serviço';
            foreach ($nets->findClient_Model_Pack() as $net) {
                $this->servicosNet[$net->idpack] = $net->name;
            }
        }

        if ($this->type == 'phone') {
            $tels = $netserv->fetchRow("type = 'tel' ");

            $this->servicosTelef[0] = 'Sem serviço';
            foreach ($tels->findClient_Model_Pack() as $net) {
                $this->servicosTelef[$net->idpack] = $net->name;
            }
        }
    }

    private $totalVals = 0;

    public function getTotalVals()
    {
        return $this->totalVals;
    }

    public function setTotalVals($totalVals)
    {
        $this->totalVals = $totalVals;
    }
    
    protected $alreadygen = false;

    private $_services = null;
    
    public function getServices()
    {
        return $this->_services;
    }
    
    public function setServices($services)
    {
        $this->_services = $services;
        return $this;
    }
    
    private $_availableEquipments = null;
    
    public function getAvailableEquipments()
    {
        return $this->_availableEquipments;
    }
    
    public function setAvailableEquipments($eqs)
    {
        $this->_availableEquipments = $eqs;
        return $this;
    }
    /**
     * @param string $type (phone, internet)
     * @param array $options|null
     * 
     */
    public function __construct($type = null, $options = array())
    {
        $this->setType($type);

        if (array_key_exists('idclient', $options)) {
            $this->idcliente = $options['idclient'];
        }
        
        if (array_key_exists('services', $options)) {
            $this->setServices($options['services']);
        }
        
        if (array_key_exists('equipments', $options)) {
            $this->setAvailableEquipments($options['equipments']);
        }
        
        if (array_key_exists('nrows', $options) && $options['nrows'] > 0 ) {
            $this->setTotalVals($options['nrows']);
        }
        
        $this->loadCombos();

        parent::__construct($options);
    }

    /**
     *
     * 
     * @return Zend_Dojo_Form_SubForm 
     */
    public function init()
    {
       
        $this->setAttribs(array(
            'legend'    => 'Serviços de ' . $this->type
            )
        );

        $this->setDecorators(array(
            'FormElements',
            array('HtmlTag', array('tag' => 'table')),
            'DijitForm'
            )
        );
        
        $this->setName($this->getType());
        $this->setIsArray(true);
        
        $this->setMethod("POST");
        $this->setAction("/client/service/v/idclient/" . 
                (int) $this->getIdcliente() . "/type/" . $this->getType()
                );
        
        $this->genrows();

        return $this;
    }

    public function genrows()
    {
        $t = count($this->getValues());
        
        if ($t <= $this->getTotalVals())
            $t = $this->getTotalVals();
        
        if ( array_key_exists($this->type, $_POST) && array_key_exists("new", $_POST[$this->type]) ) {
            $t++;
        }

        for ($i = 0; $i < $t; $i++) {
            $this->addSubForm($this->addService($i, $this->type), $i);
        }
        
        $novo = new Zend_Dojo_Form_Element_SubmitButton("new");
        $novo->setName("new")
                ->setLabel("Adicionar Novo")
                ->setIgnore(true);

        $novo->setDecorators(array(
            'DijitElement',
            array('HtmlTag',
                    array('tag' => 'td', 'colspan' => 4, 'align' => 'right')
                )
            )
        );
        
        $this->addElement($novo);
        
        $novo2 = new Zend_Dojo_Form_Element_SubmitButton("save");
        $novo2->setName("save")
                ->setLabel("Guardar")
                ->setIgnore(true);

        $novo2->setDecorators(array(
            'DijitElement',
            array('HtmlTag',
                    array('tag' => 'td', 'colspan' => 2, 'align' => 'left')
                )
            )
        );
        
        $this->addElement($novo2);
    }

    /**
     *
     * display service
     * 
     * @param int $i number of service
     * @param string $type (phone, internet)
     * 
     * @return Zend_Form_SubForm 
     */
    public function addService($i, $type)
    {
        $sub = new Zend_Dojo_Form_SubForm();
        $sub->setIsArray(true);
        
        $sub->setDecorators(array(
            'FormElements',
            array('HtmlTag', array('tag' => 'tr'))
        ));
        
        $Equipamentos = $this->_availableEquipments;

        if (count($Equipamentos) <= 0) {
            return $sub;
        }

        $id = new Zend_Form_Element_Hidden("idservice");
        $id->setDecorators(array('ViewHelper'));
        $sub->addElement($id);

        $net = new Zend_Dojo_Form_Element_FilteringSelect("idpack");
        $net->setLabel('Serviço ' . ($i + 1));
        
        if ($this->type == "internet") {
            // NET 
            $net->setMultiOptions($this->servicosNet);
            $net->setLabel(" Internet " . $net->getLabel());
            $net->addValidator(new Zend_Validate_GreaterThan(0));
        } else {
            // Telefone
            $net->setLabel(" Telefone " . $net->getLabel());
            $net->setMultiOptions($this->servicosTelef)
                    ->setOptions(array(
                        "onChange" => "formclienteComboTel('" . $i . "-idpack');"
                            )
                    )
                    ->setRegisterInArrayValidator(false);
            $net->addValidator(new Zend_Validate_GreaterThan(0));
        }

        $sub->addElement($net);

        $netmac = new Zend_Dojo_Form_Element_FilteringSelect("idequipment");
        $netmac->setDecorators(array('DijitElement'));
        $netmac->setLabel("Equipamento");
        $netmac->setMultiOptions($Equipamentos);
        $netmac->setRequired(true);
        $netmac->addValidator(new Zend_Validate_GreaterThan(0));
        
        $sub->addElement($netmac);

        if ($this->type != "internet") {
            $telnum = new Zend_Dojo_Form_Element_TextBox("tel");
            $telnum->setLabel("Número");
            
            $linenumber = new Zend_Dojo_Form_Element_FilteringSelect("linenumber");
            $linenumber->setMultiOptions(array(0, 1, 2));
            $linenumber->setLabel("Linha")
                    ->addValidator(new Zend_Validate_GreaterThan(0));
        } else {
            $telnum = new Zend_Form_Element_Hidden("tel");
            $linenumber = new Zend_Form_Element_Hidden("linenumber");
        }
        $sub->addElement($telnum);
        $sub->addElement($linenumber);
        
        $canceldate = new Zend_Dojo_Form_Element_DateTextBox("dataunactive");
        $canceldate->setLabel("Data da anulação")
                ->setDescription("<a href='#' onClick=\"javascript:removerServico( '$type'," . $i . ");\">
                               <img src=\"/img/cancel.png\" alt=\"cancelar\" width='14' height='14'/>
                               </a>");

        $sub->addElement($canceldate);

        $sub->setElementDecorators(array(
            'DijitElement',
            'Label',
            'Errors',
            new Zend_Form_Decorator_Description(
                    array('escape' => false, 'tag' => false)
            ),
            new Zend_Form_Decorator_HtmlTag(array('tag' => 'td'))
                ), array(
            "idservice",
            "idequipment",
            "idpack",
            "tel", 
            "linenumber",
            "dataunactive",
            "response2"
                )
        );

        $telnum->addDecorator(
                array('row' => 'HtmlTag'), array('tag' => 'div')
        );

        $row = $telnum->getDecorator("row");
        $row->setOption("style", "display: none;")
                ->setOption("id", "divme" . $i . "-idpack")
        ;

        return $sub;
    }

    public function preValidate(array $Data)
    {
        if (array_key_exists($this->getName(), $Data)) {
            $Data = $Data[$this->getName()];
        }
        $this->setTotalVals(count($Data));

        $this->genRows();
        return $this;
    }

    public function setDefaults(array $defaults)
    {        
        $r = parent::setDefaults($defaults);

        foreach ($this->getSubForms() as $sf) {
            if (trim($sf->getValue("dataunactive")) != '' && $sf->getValue("dataunactive") != '0000-00-00 00:00:00') {
                $sf->getDecorator("HtmlTag")->setOption("class", "disabled-back");
                $sf->getElement("dataunactive")->setDescription("");
            }
        }

        return $r;
    }

}
