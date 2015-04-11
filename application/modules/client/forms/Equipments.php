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
 * Description of Equipments
 *
 * @author andref
 * @version $Id$
 */
class Client_Form_Equipments extends Zend_Dojo_Form_SubForm
{
    private $types;
    
    public function getEqTypes()
    {
        return $this->types;
    }
    
    public function setEqTypes($types)
    {
        $this->types = $types;
    }
    
    private $_idclient = 0;
    
    public function setIdClient($id)
    {
        $this->_idclient = (int) $id;
    }
    
    public function getIdClient()
    {
        return $this->_idclient;
    }
    
    public function __construct($options = array())
    {        
        if (array_key_exists("typeequipments", $options)) {
            $this->setEqTypes($options['typeequipments']);
            unset($options['typeequipments']);
        }

        if (array_key_exists("idclient", $options)) {
            $this->setIdClient($options['idclient']);
            unset($options['idclient']);
        }
        
        return parent::__construct($options);
    }

    public function init()
    {
        $this->setName("devices");

        $this->setIsArray(true);

        $tmp = '';
        if ($this->getIdClient() > 0 ) {
            $tmp = "idclient/" . $this->getIdClient();
        }
        
        $this->setAction("/client/equipment/v/" . $tmp);

        $this->setMethod("POST");
        
        $this->setLegend("Equipamento");
        $this->setAttrib("dijitParams", array(
                'title' => 'Equipamentos'
        ));
                
        $this->setDecorators(array(
            'FormElements',
                new Zend_Form_Decorator_Description(
                    array('escape' => false, 'tag' => false)
                ),
                array('HtmlTag',
                    array('tag' => 'table', 'height' => '20', 
                        "id" => "equipmentsTable")
                )         
            ,'DijitForm'
            )
        );

        $this->addSubForm($this->addDevice(0), "0");
        
        $r = new Zend_Dojo_Form_Element_SubmitButton("record");
        $r->setIgnore(true);
        $r->setLabel("Gravar");
        
        $this->addElement($r);
                        
        return $this;
    }
    
    public function addDevice($i)
    {
        $sub = new Zend_Dojo_Form_SubForm();
        $sub->setIsArray(true);
        $sub->setName($i);
        $sub->setDecorators(array(
            'FormElements'
            ,'Errors'  => array('HtmlTag', array('tag' => 'span'))
            ,array('HtmlTag', array('tag' => 'tr'))
        ));

        $id = new Zend_Form_Element_Hidden("idequipment");
        $sub->addElement($id);
        
        $idc = new Zend_Form_Element_Hidden("idclient");
        if ( $idclient = $this->getIdClient() ) {
            $idc->setValue($idclient);
        }
        $sub->addElement($idc);

        $types = $this->getEqTypes();

        $cmb = new Zend_Dojo_Form_Element_FilteringSelect("idtypeequipment");
        $cmb->setLabel("Tipo Equipamento");
        
        $tmpName = $this->getName(). "-" .
                ( $sub->getName() <= 0 ? 0 : $sub->getName() ) . "-".$cmb->getName();
        $cmb->setMultiOptions($types);
        $cmb->setAttrib(
                "onChange", "javascript:isCM('" . $tmpName ."');"
                );
        $cmb->setRequired();
        $sub->addElement($cmb);
                
        $serialn = new Zend_Dojo_Form_Element_TextBox("serialnum");
        $serialn->setLabel("Nº Série");
        $serialn->setRequired();
        $sub->addElement($serialn);

        $macaddr = new Zend_Dojo_Form_Element_TextBox("macaddr");
        $macaddr->setLabel("CMac")
                ->setAttrib("MAXLENGTH", 12)
                ->addValidator('regex', false, array('/[0-9A-Z]+/i'))
                ->addValidator('StringLength', false, array(12));
        $sub->addElement($macaddr);
        
        $dataout = new Zend_Dojo_Form_Element_DateTextBox("dataout");
        $dataout->setLabel("Data de anulação");
        /*
         * 
          $dataout->setDescription(
                "<a href=\"#\" onclick=\"javascript:anulardevice($i);\">
                            &nbsp;<img src=\"/img/cancel.png\" alt=\"cancelar\" width='14' height='14' align='right'/>
                        </a>"
        );
         */
        $sub->addElement($dataout);

        $sub->setElementDecorators(array(
            'DijitElement',
            'Label',
            'Errors',
            new Zend_Form_Decorator_Description(
                    array('escape' => false, 'tag' => false)
            ),
            new Zend_Form_Decorator_HtmlTag(array('tag' => 'td')) //wrap elements in <td>'s
                ), array(
            "idequipment",
            "idtypeequipment",
            "typeequipment",
            "serialnum",
            "macaddr",
            "dataout"
                )
        );
        
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

    public function a_setDefaults(array $defaults)
    {
        $r = parent::setDefaults($defaults);
        
        foreach ($this->getSubForms() as $equip) {
            $equip->setAttrib("disabled", true);
            if (trim($equip->getValue("dataout")) != '' && $equip->getValue("dataout") != '0000-00-00 00:00:00') {
                $equip->getDecorator("HtmlTag")->setOption("class", "disabled-back");
                $equip->getElement("dataout")->setDescription("");
            }
        }

        return $r;
    }

}
