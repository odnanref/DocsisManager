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
 * Description of RemoteQuery
 *
 * Form to display data returned by the ajax call for a remote CM query
 *
 * @author andref
 * @version $Id$
 */
class DM_Form_RemoteQuery extends Zend_Dojo_Form
{
    private $_macaddr;

    public function __construct($options = array())
    {
        if (array_key_exists("macaddr", $options)) {
            $this->_macaddr = $options['macaddr'];
        }
        parent::__construct($options);
    }

    public function init()
    {
        $this->setMethod("POST");
        $this->setAction("/docsismodem/getremotequery/");
        $this->setIsArray(true);
        $this->setName("rq");

        $mac = new Zend_Form_Element_Hidden("id");
        if ($this->_macaddr !== null ) {
            $mac->setValue($this->_macaddr);
        }
        $this->addElement($mac);
        $mac->clearDecorators();
        $mac->addDecorator(new Zend_Form_Decorator_ViewHelper());

        $this->addElement(
             'TextBox', 'downstreamfreq', array(
            'label' => "Downstream",
            'trim' => true
            , 'disabled' => true
                )
        );

        $this->addElement(
             'TextBox', 'upstreamfreq', array(
            'label' => "Upstream",
            'trim' => true
            ,'disabled' => true
                )
        );

        $this->addElement(
             'TextBox', 'tx', array(
            'label' => "TX",
            'trim' => true
            , 'disabled' => true
                )
        );

        $this->addElement(
                'TextBox', 'rx', array(
            'label' => "RX",
            'trim' => true
            , 'disabled' => true
                )
        );

        $this->addElement(
            'TextBox', 'snr', array(
            'label' => "SNR",
            'trim' => true
            , 'disabled' => true
                )
        );

        $this->addElement(
            'TextBox', 'imagefile', array(
            'label' => "Boot File",
            'trim' => true
            , 'disabled' => true
                )
        );

        $version = new Zend_Dojo_Form_Element_Textarea("version");
        $version->setLabel("M. Info");
        $version->setAttrib("disabled", "true");
        $this->addElement($version);

        $this->addElement(
            'TextBox', 'hw_rev', array(
            'label' => "HW_Rev",
            'trim' => true
            ,'disabled' => true
             )
        );

        $this->addElement(
            'TextBox', 'vendor', array(
            'label' => "Vendor",
            'trim' => true
            ,'disabled' => true
             )
        );

        $this->addElement(
            'TextBox', 'model', array(
            'label' => "Model",
            'trim' => true
            ,'disabled' => true
             )
        );

        $this->addElement(
            'TextBox', 'bootr', array(
            'label' => "BOOTR",
            'trim' => true
            ,'disabled' => true
             )
        );

        $this->addElement(
            'TextBox', 'sw_rev', array(
            'label' => "SW_REV",
            'trim' => true
            ,'disabled' => true
             )
        );

        $log = new Zend_Form_Element_Textarea("log");
        $log->setLabel("Log");
        $log->setAttrib("rows", "2");
        $this->addElement($log);

        $sub = new Zend_Dojo_Form_Element_Button("consultar");
        $sub->setIgnore(true);
        $sub->setLabel("Consultar Remoto");

        $sub->setAttrib("onClick", "remotequery();");
        $this->addElement($sub);

        return $this;
    }

}
