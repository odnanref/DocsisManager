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
 * Form Add for cable modem for simple usage
 *
 * @author andref
 */
class DM_Form_DMAdd extends Zend_Dojo_Form
{
    private $_macaddr = "";

    public function setMac($mac)
    {
        $this->_macaddr = $mac;
        return $this;
    }

    public function getMac()
    {
        return $this->_macaddr;
    }

    private $_cfgfiles = array();

    public function setConfigFiles($_cfgfiles)
    {
        $this->_cfgfiles = $_cfgfiles;
        return $this;
    }

    public function getConfigFiles()
    {
        return $this->_cfgfiles;
    }

    public function getBrandToOption()
    {
        $pack = array('0' => '');
        if ($this->_brands === null ) {
            return $pack;
        }

        foreach ($this->_brands as $m) {
            $pack[$m->idbrand] = $m->name;
        }
        return $pack;
    }

    private $_brands = null;

    public function setBrands($brands)
    {
        $this->_brands = $brands;
        return $this;
    }

    /**
     * Constructor
     *
     * @param  array|Zend_Config|null $options
     * @return void
     */
    public function __construct($options = array())
    {
        if (array_key_exists("brands", $options)) {
            $this->setBrands($options['brands']);
        }

        if (array_key_exists("macaddr", $options)) {
            $this->setMac($options['macaddr']);
        }

        if (array_key_exists("configfiles", $options)) {
            $this->setConfigFiles($options['configfiles']);
        }

        parent::__construct($options);
    }

    public function init()
    {
        $this->setName("docsismodem");
        $this->setMethod("POST");

        $this->setDecorators(array(
            'FormElements',
            array(
                'TabContainer',
                array(
                    'id' => 'tabContainer',
                    'style' => 'width:660px; height:350px',
                    'dijitParams' => array(
                        'tabPosition' => 'top',
                    )
                ),
                'DijitForm'
            ),
            "Form"
        ));

        $this->addSubForm($this->dm(), "docsismodem");
        $this->addSubForm($this->mta(), "mta");
        $this->addSubForm($this->servico(), "servico");
        $this->addSubForm($this->aparelho(), "aparelho");

        $end = new Zend_Dojo_Form_SubForm(array("name" => "terminar",
            'legend' => 'Guardar',
            'dijitParams' => array(
                'title' => 'Guardar',
            )));
        $add = new Zend_Dojo_Form_Element_SubmitButton("Add");
        $add->setLabel("Salvar")->setIgnore(true);
        $end->addElement($add);

        $this->addSubForm($end, "terminar");

        return $this;
    }

    public function dm()
    {
        $textForm = new Zend_Dojo_Form_SubForm();

        $textForm->setAttribs(array(
            'name' => 'docsismodem',
            'legend' => '1. Modem',
            'dijitParams' => array(
                'title' => '1. Modem',
            )
        ));

        $textForm->addElement(
            'TextBox', 'macaddr', array(
            'label' => 'Mac Address',
            'trim' => true,
            'propercase' => true,
            'required' => true
                )
        );
        $maaddrEl = $textForm->getElement("macaddr");
        $maaddrEl
                ->addPrefixPath('DM_Filter', APPLICATION_PATH . '/filters/', 'filter')
                ->addValidator('regex', false, array('/^[a-z0-9]*$/i'))
                ->addValidator('StringLength', false, array(12,12))
                ->addValidator("NotEmpty", false)
                ->addFilter("StringToUpper")
                ->addFilter('StringTrim')
                ->addFilter("CleanMacAddress");

        $textForm->addElement(
            'TextBox', 'serialnum', array(
            'label' => "Numero de serie",
            'trim' => true
                )
        );

        $textForm->addElement(
            'TextBox', 'node', array(
            'label' => "Célula",
            'trim' => true
                )
        );

        $nodeEl = $textForm->getElement("node");
        $nodeEl->addValidator('StringLength', false, array(2,10))
                ->addFilter("StringToUpper")
                ->addFilter("StringTrim");
        
        return $textForm;
    }

    public function mta()
    {
        $toggleForm = new Zend_Dojo_Form_SubForm();

        $toggleForm->setAttribs(array(
            'name' => 'toggletab',
            'legend' => '2. MTA',
        ));

        $toggleForm->addElement(
            'TextBox', 'macaddr_mta', array(
            'label' => "MAC Addr MTA",
            'trim' => true
             )
        );
        $toggleForm->getElement("macaddr_mta")
                ->addValidator('regex', false, array('/^[a-z0-9]*$/i'));

        $toggleForm->addElement(
            'TextBox', 'tel1', array(
            'label' => "Linha 1",
            'trim' => true,
            'required' => false
             )
        );
        $toggleForm->getElement("tel1")
                ->addValidator('StringLength', false, array(9,12));

        $toggleForm->addElement(
            'TextBox', 'tel2', array(
            'label' => "Linha 2",
            'trim' => true,
            'required' => false
             )
        );

        $toggleForm->getElement("tel2")
                ->addValidator('StringLength', false, array(9,12));

        return $toggleForm;
    }

    public function servico()
    {
        $toggleForm = new Zend_Dojo_Form_SubForm();

        $toggleForm->setAttribs(array(
            'name' => 'servico',
            'legend' => '3. Servi&ccedil;o',
        ));

        $toggleForm->addElement(
            'TextBox', 'config_file',
                array(
                'label' => "Boot File",
                'trim' => true,
                'required' => false
                )
        );

        $toggleForm->getElement("config_file")
                ->setAttrib("style", "width: 400px;")
                ->addValidator('regex', false, array('/^[a-z0-9\_\.-]*$/i'))
                ->addFilter('StringTrim');

        $lFiles = new Zend_Dojo_Form_Element_FilteringSelect("listFiles");
        $lFiles->setMultiOptions($this->getConfigFiles());
        $lFiles->setAutocomplete(true);
        $lFiles->setLabel("Pre-construídos");
        $lFiles->setIgnore(true)
                ->setAttrib("style", "width: 200px;")
                ->setAttrib("onChange", "selectFile");


        $toggleForm->addElement($lFiles);

        $toggleForm->addElement(
            'FilteringSelect', 'estado', array(
            'label' => 'Estado',
            'autocomplete' => true,
            'multiOptions' => array(
                0 => ''
                , 'activo'  => 'Activo'
                , 'cortado' => "Cortado"
                , 'anulado' => 'Anulado')
                )
        );

        return $toggleForm;
    }

    public function aparelho()
    {
        $selectForm = new Zend_Dojo_Form_SubForm();

        $selectForm->setAttribs(array(
            'name' => 'selecttab',
            'legend' => '4. Equipamento',
        ));

        $selectForm->addElement(
            'FilteringSelect', 'brand', array(
            'label' => 'Marca',
            'autocomplete' => false,
            'multiOptions' => $this->getBrandToOption(),
            'onChange' => 'loadModelo()'
                )
        );

        $selectForm->brand->setIgnore(true);

        $selectForm->addElement(
            'FilteringSelect', 'idmodel',
            array(
                'label' => 'Modelo',
                'storeId' => 'readStore',
                'storeType' => 'dojo.data.ItemFileReadStore',
                'autocomplete' => false,
                'storeParams' => array(
                    'url' =>
                    "/device/getmodel/?idbrand=" .
                        (int) $selectForm->brand->getValue()
                ),
                'dijitParams' => array(
                    'searchAttr' => 'description',
                    )
            )
        );

        return $selectForm;
    }
}
