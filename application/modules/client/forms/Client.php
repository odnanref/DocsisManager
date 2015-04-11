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
 * Description of Client
 *
 * @author andref
 * @version $Id$
 */
class Client_Form_Client extends Zend_Dojo_Form
{

    private $estados = array(
        ''
        , 'active' => 'Activo'
        , 'cut' => "Cortado"
        , 'unactive' => "Anulado"
    );
    private $servicosNet = array();
    private $servicosTelef = array();
    private $data;
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

    public function init()
    {
        $this->setMethod('post');
        $this->setName("userform");
        
        $this->addSubForm($this->clienteinfo(), 'clienteinfo')
                ->addSubForm($this->contacto(), 'contacto');

        $this->addSubmitButton();
    }

    public function clienteinfo()
    {
        $form = new Zend_Dojo_Form_SubForm();
        $form->setAttribs(
                array(
                    'name'      => 'textboxtab',
                    'legend'    => 'Cliente'
                )
        );

        $form->removeDecorator("Description");
        $form->addDecorator(
                new Zend_Form_Decorator_Description(
                        array('escape' => false, 'tag' => false)
                )
        );
        $form->setDescription("<div id=\"response2\"></div>");

        $eid = new Zend_Form_Element_Hidden("idclient");
        $form->addElement($eid);

        $nome = new Zend_Dojo_Form_Element_TextBox("name");
        $nome->setLabel("Nome")
                ->setOptions(array(
                    "maxlength" => "240",
                    "size" => "60"
                        )
        );

        $form->addElement($nome);

        $contrato = new Zend_Dojo_Form_Element_TextBox("contract");
        $contrato->setLabel("Contrato");

        if ($this->getValue("contract") !== null) {
            $contrato->setOptions(array('disabled' => 'disabled'));
        }

        $form->addElement($contrato);

        $c = new Zend_Dojo_Form_Element_TextBox("node");
        $c->setLabel("Célula");
        $form->addElement($c);

        $estado = new Zend_Dojo_Form_Element_FilteringSelect("state");
        $estado->setLabel("Estado");
        $estado->setMultiOptions($this->estados);
        $form->addElement($estado);

        return $form;
    }

    public function contacto()
    {
        $form = new Zend_Dojo_Form_SubForm();
        $form->setAttribs(array(
            'name' => 'textboxtab',
            'legend' => 'Contactos'
            )
        );

        $contacto = new Zend_Dojo_Form_Element_TextBox("phone");
        $contacto->setLabel("Telefone");
        $form->addElement($contacto);

        $contacto2 = new Zend_Dojo_Form_Element_TextBox("mobile");
        $contacto2->setLabel("Telemovel");
        $form->addElement($contacto2);

        $contacto3 = new Zend_Dojo_Form_Element_TextBox("email");
        $contacto3->setLabel("E-mail");
        $form->addElement($contacto3);

        return $form;
    }

    public function loadClientDetails()
    {
        if ($this->getIdclient() <= 0) {
            return null;
        }

        $opt = array('idclient' => $this->getIdclient());

        $formDev = new Client_Form_Equipments($opt);
        $this->addSubForm($formDev, "devices");

        if ($formDev->getTotalDevices() > 0 ) {
            $this->addSubForm(new Client_Form_Services("internet", $opt), 
                    "serviceinternet");

            $this->addSubForm(new Client_Form_Services("phone", $opt), 
                    "servicephone");
        }
        
        $this->removeElement("gravar");
        $this->addSubmitButton();
    }
    
    private function addSubmitButton()
    {
        $sb = new Zend_Dojo_Form_Element_SubmitButton("gravar");
        $sb->setName("gravar");
        $sb->setLabel("Gravar");

        $this->addElement($sb);
    }

}
