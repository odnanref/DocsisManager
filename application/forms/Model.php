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
 * Form regarding a model for a brand equipment / device
 *
 * @author andref
 * @version $Id$
 */
class DM_Form_Model  extends Zend_Form
{
    private $data;

    /**
     * Set the variable data
     *
     * @var string $data
     * @return Docsismodem
     */
    public function setdata($data) {
        $this->data = $data;
        return $this;
    }

    /**
     * Get the variable data
     *
     * @param string $varname (Estado, macaddr, ipaddr, etc...)
     * @return String
     */
    public function getdata($varname = null) {
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

    /**
     * Brand Db Object
     *
     * @var DM_Model_Brand
     */
    private $_brands;

    public function setBrands($_brands)
    {
        $this->_brands = $_brands;
        return $this;
    }

    public function getBrands()
    {
        return $this->_brands;
    }


    /**
     * Constructor
     *
     * @param  array|Zend_Config|null $options
     * @return void
     */
    public function __construct($options = null)
    {
    	if (($options instanceof DM_Model_Modelo) === true ||
                ($options instanceof Zend_Db_Table_Row)) {
            $this->setdata($options);
    	}

        if (is_array($options) && array_key_exists("brands", $options)) {
            $this->setBrands($options['brands']);
    	}
    	parent::__construct($options);
    }

    public function getBrandToOption()
    {
    	$pack = array('0' => '');
    	foreach ( $this->getBrands()->fetchAll() as $m ) {
    		$pack[$m->idbrand] = $m->name;
    	}
    	return $pack;
    }

    public function init()
    {
        $this->setElementDecorators(array(
            'ViewHelper',
            'Errors',
            array(array('data' => 'HtmlTag'), array('tag' => 'td')),
            array('Label', array('tag' => 'td')),
            array(array('row' => 'HtmlTag'), array('tag' => 'tr'))
        ));

        $this->setDecorators(array(
            'FormElements',
            array('HtmlTag', array('tag' => 'table')),
            'Form',
        ));

        $this->setMethod("post");

        $id       = $this->addElement('hidden','idmodel');

        $this->addElement(
            'select',
            'idbrand',
            array(
                'label' => 'Marca',
                'autocomplete'	=>	false,
                'multiOptions'	=>	$this->getBrandToOption(),
                'value' => $this->getdata("idbrand")
            )
        );

        $this->addElement('text', 'description', array(
            'required'   => true,
            'label'      => 'Modelo',
        ));
        $model = $this->getElement("description");
        $model->addFilter(new Zend_Filter_Null(Zend_Filter_Null::STRING));

        $vendormac = $this->addElement('text', 'vendormac', array(
            'required'   => false,
            'label'      => 'Vendor Mac',
            'value' => $this->getdata("vendormac")
        ));

        $this->addElement('text', 'default_file', array(
            'label'      => 'Ficheiro Padrão'
        ));
        $Default_File = $this->getElement("default_file");
        $Default_File->addFilter(new Zend_Filter_Null(Zend_Filter_Null::STRING));

        $this->addElement('text',
                'default_file_phone_on', array(
                    'label'      => 'Ficheiro Padrão MTA Ligado'
                )
        );
        $Default_File_phone_on = $this->getElement("default_file_phone_on");
        $Default_File_phone_on
        ->addFilter(new Zend_Filter_Null(Zend_Filter_Null::STRING));

        $this->addElement('text', 'default_file_mta', array(
            'label'      => 'Ficheiro Padrão EMTA'
        ));

        $Default_File_mta = $this->getElement("default_file_mta");
        $Default_File_mta->addFilter(new Zend_Filter_Null(Zend_Filter_Null::STRING));

        $this->addElement("checkbox", "onefilemta", array('label' => "MTA Ficheiro Único"));

        $login = $this->addElement('submit', 'Gravar', array(
            'required' => false,
            'ignore'   => true,
            'label'    => 'Gravar',
        ));

        $element = $this->getElement('Gravar');
        $element->removeDecorator('Label');
    }
}

?>
