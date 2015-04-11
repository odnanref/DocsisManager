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
 * @package DM
 * @subpackage Form
 *
 * @author andref
 * @version $Id$
 *
 */
class DM_Form_DojoDocsismodem extends Zend_Dojo_Form
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

    private $data;

    /**
     * Set the variable data
     *
     * @var string $data
     * @return Docsismodem
     */
    public function setdata($data)
    {
        $this->data = $data;
        return $this;
    }

    /**
     * Get the variable data
     *
     * @param string $varname (Estado, macaddr, ipaddr, etc...)
     * @return String
     */
    public function getdata($varname = null)
    {
        if ($varname !== null && is_object($this->data)) {
            if (array_key_exists($varname, $this->data->toArray())) {
                return $this->data->$varname;
            } else {
                return null;
            }
        }

        if ($this->data !== null) {
            return $this->data;
        }

        return null;
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

    private $_selectOptions;

    private $_selectModelos;

    /**
     * Constructor
     *
     * @param  array|Zend_Config|null $options
     * @return void
     */
    public function __construct($options = array())
    {
        if (($options instanceof DM_Model_Docsismodem) === true) {
            $this->setdata($options);
        }

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

    private $_brands = null;

    public function setBrands($brands)
    {
        $this->_brands = $brands;
        return $this;
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

    public function init()
    {
        $this->setName("dojodocsismodemform");
        $this->setIsArray(false);

        $this->addSubForm($this->ainit(), "main");

        $save = new Zend_Dojo_Form_Element_SubmitButton("save");
        $save->setLabel("Guardar");
        $save->setIgnore(true);

        $this->addElement($save);

        $temp = '';
        if (($mac = $this->getMac()) !== null ) {
            $temp = "id/" . $this->getMac();
        }

        $tmp = "/docsismodem/ver/" . $temp;

        $this->setMethod('POST');
        $this->setAction($tmp);

    }

    public function ainit()
    {
        $this->_selectOptions = $this->getBrandToOption();

        $form = new Zend_Dojo_Form_SubForm();
        $form->setIsArray(false);

        $form->setDecorators(array(
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
            )
        ));

        $form->addSubForm($this->modeminfo(), 'Docsismodem');
        $form->addSubForm($this->mta(), 'mta');
        $form->addSubForm($this->servico(), 'servico');
        $form->addSubForm($this->aparelho(), 'aparelho');
        $form->addSubForm(new DM_Form_ConfigFile(), "configfile");

        return $form;
    }

    public function modeminfo()
    {
        $textForm = new Zend_Dojo_Form_SubForm();
        $textForm->setAttribs(array(
            'name' => 'textboxtab',
            'legend' => 'Modem Info',
            'dijitParams' => array(
                'title' => 'Modem Info',
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

        $textForm->addElement(
            'TextBox', 'ipaddr', array(
            'label' => "IP",
            'trim' => true
                )
        );
        $textForm->ipaddr->setAttrib("disabled", "disabled");
        $textForm->ipaddr->setIgnore(true);

        $textForm->addElement(
            'TextBox', 'first_online', array(
            'label' => 'Primeira vez online'
                )
        );
        $textForm->first_online->setAttrib("disabled", "disabled");
        $textForm->first_online->setIgnore(true);

        $textForm->addElement(
            'TextBox', 'last_online', array(
            'label' => 'Ultima vez online'
                )
        );
        $textForm->last_online->setIgnore(true);

        $textForm->addElement(
            'TextBox', 'lastip', array(
            'label' => "Ultimo IP usado",
            'trim' => true
                )
        );

        $textForm->lastip->setIgnore(true);

        $textForm->addElement(
            'TextBox', 'reg_count', array(
            'label' => 'Total de registos'
                )
        );
        $textForm->reg_count->setIgnore(true);

        return $textForm;
    }

    public function mta()
    {
        $toggleForm = new Zend_Dojo_Form_SubForm();

        $toggleForm->setAttribs(array(
            'name' => 'toggletab',
            'legend' => 'MTA',
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
            'TextBox', 'config_file_mta', array(
            'label' => "Boot File MTA",
            'trim' => true,
            'required' => false
             )
        );
        $toggleForm->getElement("config_file_mta")
                ->addValidator('regex', false, array('/^[a-z0-9\_\.-]*$/i'))
                ->addFilter('StringTrim');

        $toggleForm->addElement(
            'TextBox', 'tel1', array(
            'label' => "Tel 1",
            'trim' => true,
            'required' => false
             )
        );
        $toggleForm->getElement("tel1")
                ->addValidator('StringLength', false, array(9,12));

        $toggleForm->addElement(
            'TextBox', 'tel2', array(
            'label' => "Tel 2",
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
            'name' => 'toggletab',
            'legend' => 'Servi&ccedil;o',
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
            'legend' => 'Aparelho',
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

    public function setModelOptions($idbrand)
    {
        $elm = $this->getSubForm("main")->getSubForm("aparelho")->getElement("idmodel");
        $a = $elm->setStoreParams(array('url' => "/device/getmodel/?idbrand=" . (int) $idbrand));
        return $this;
    }

}
