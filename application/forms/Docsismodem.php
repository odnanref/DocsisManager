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
 * Form for searching a cm in the docsismodem table
 *
 * @package DM
 * @subpackage Form
 *
 * @author andref
 * @version $Id$
 *
 */
class DM_Form_Docsismodem extends Zend_Dojo_Form
{
    private $_models = array(0 => '');

    public function getModels()
    {
        return $this->_models;
    }

    public function setModels(Zend_Db_Table_Rowset $models)
    {
        foreach ( $models as $model ) {
            $this->_models[$model->idmodel] = $model->name . " " .
                    $model->description;
        }
    }

    /**
     * Constructor
     *
     * @param  array|Zend_Config|null $options
     * @return void
     */
    public function __construct($options = null)
    {
        if (count($options) > 0 ) {
            if (array_key_exists("models", $options)) {
                $this->setModels($options['models']);
            }
        }
        parent::__construct($options);
    }

    public function init()
    {
        $this->setName("docsismodemform");

        $this->setAttribs(array(
            'name' => 'docsismodemform'
        ));

        $this->addSubForm($this->modeminfo(), 'Docsismodem');

        $this->setMethod('post');
        $this->setAction("/docsismodem/search/");

        $sb = new Zend_Form_Element_Submit("Procurar");
        $sb->setLabel("Procurar");
        $this->addElement($sb);
    }

    public function modeminfo()
    {
        $textForm = new Zend_Dojo_Form_SubForm();
        $textForm->setAttribs(array(
            'name' => 'textboxtab',
            'legend' => 'Procurar Modem'
        ));

        $mac = new Zend_Dojo_Form_Element_TextBox("macaddr");
        $mac->setLabel("Mac Address")
            ->addPrefixPath('DM_Filter', APPLICATION_PATH . '/filters/', 'filter')
            ->addFilter('StringTrim')
            ->addFilter("CleanMacAddress");
        $textForm->addElement($mac);

        $sn = new Zend_Dojo_Form_Element_TextBox("serialnum");
        $sn->setLabel("Numero de serie")
            ->addFilter('StringTrim');

        $textForm->addElement($sn);

        $ip = new Zend_Dojo_Form_Element_TextBox("ipaddr");
        $ip->setLabel("Endereço IP")
           ->addFilter('StringTrim');

        $textForm->addElement($ip);

        $f = new Zend_Dojo_Form_Element_TextBox("config_file");
        $f->setLabel("Ficheiro")
                ->addFilter('StringTrim');

        $textForm->addElement($f);

        $t = new Zend_Dojo_Form_Element_TextBox("phone");
        $t->setLabel("Telefone")->addFilter('StringTrim');
        $textForm->addElement($t);

        $est = new Zend_Dojo_Form_Element_FilteringSelect("estado");
        $est->setMultiOptions(array(0 => '', 'activo' => 'Activo'
            , 'cortado' => "Cortado", 'inactivo' => 'Inactivo')
        );
        $est->setAutocomplete(true);
        $est->setLabel("Estado");

        $textForm->addElement($est);

        $est2 = new Zend_Dojo_Form_Element_FilteringSelect("idmodel");
        $est2->setMultiOptions($this->getModels());
        $est2->setAutocomplete(true);
        $est2->setLabel("Modelos");

        $textForm->addElement($est2);

        $node = new Zend_Dojo_Form_Element_TextBox("node");
        $node->setLabel("Celula");
        $textForm->addElement($node);

        return $textForm;
    }


}
