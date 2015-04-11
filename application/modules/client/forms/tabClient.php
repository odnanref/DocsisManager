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

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of tabClient
 *
 * @author andref
 * @version $Id$
 */
class Client_Form_tabClient extends Zend_Dojo_Form
{
    /**
     * ID do cliente
     *
     * @var int $_idcliente
     */
    private $_idcliente;

    public function getIdclient()
    {
        return $this->_idcliente;
    }

    public function setIdclient($idcliente)
    {
        $this->_idcliente = (int) $idcliente;
        return $this;
    }
    
    public function __construct($options = array())
    {
        if (array_key_exists("idclient", $options)) {
            $this->setIdclient($options['idclient']);
        }
        parent::__construct($options);
    }
    
    public function init()
    {
        $this->setName("tabClient");
        $this->setIsArray(false);
        $this->setMethod("POST");
        
        $this->setDecorators(array(
            'FormElements',
            array(
                'TabContainer',
                array(
                    'id' => 'tabContainer',
                    'style' => 'width:700px; height:450px',
                    'dijitParams' => array(
                        'tabPosition' => 'left',
                    )
                ),
                'DijitForm'
            )
        ));
        
        $this->addSubForm($this->clientestep1(), "main");
        $this->addSubForm($this->clientEquipments(), "equipments");

        $save = new Zend_Dojo_Form_Element_SubmitButton("save");
        $save->setLabel("Guardar");
        $save->setIgnore(true);
        //$this->addElement($save);
    }
    /**
     * Start/Edit client basic info
     * 
     * @return Zend_Dojo_Form_SubForm 
     */
    protected function clientestep1()
    {
        $sub = new Zend_Dojo_Form_SubForm();
        $sub->setIsArray(false);
        $sub->setAttribs(array ('dijitParams' => array(
                        'title' => 'Cliente',
                    ) ) );
        
        $cltf = new Client_Form_Client();
        $sub->addSubForm($cltf->clienteinfo(), "userform");
        $sub->addSubForm($cltf->contacto(), "contacto");
        
        return $sub;
    }
    
    protected function clientEquipments()
    {
        $sub = new Zend_Dojo_Form_SubForm();
        $sub->setIsArray(false);
        $sub->setAttribs(
                array ('dijitParams' => array(
                        'title' => 'Equipamentos',
                    ) 
            ) 
        );
        
        $sub->addSubForm(new Client_Form_Equipments(
                array('idclient' => $this->getIdclient())), 
                "devices"
                );
        
        return $sub;
    }
}
