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
 * Description of Signalfilter
 *
 * Not thinking on using this has a web form
 * Just thinking on it for a validation of the real form
 *
 * @author andref
 */
class DM_Form_Signalfilter extends Zend_Form
{
    public function init()
    {
        $this->setName("filterd");
        $this->setMethod("POST");
        $this->setIsArray(true);

        $f1 = new Zend_Form_SubForm();
        // TX
        $tx1mark = new Zend_Form_Element_Select("mark");
        $tx1mark->setMultiOptions(array("=", ">=", "<=", "<", ">"));
        $tx1mark->setBelongsTo("tx1");

        $tx1 = new Zend_Form_Element_Text("value");
        $tx1->setLabel("Entre ");
        $tx1->setBelongsTo("tx1");

        $f1->addElements([$tx1mark, $tx1]);
        $this->addSubForm($f1, "tx1");

        $tx2mark = new Zend_Form_Element_Select("mark");
        $tx2mark->setBelongsTo("tx2");
        $tx2mark->setMultiOptions(array("=", ">=", "<=", "<", ">"));

        $tx2 = new Zend_Form_Element_Text("value");
        $tx2->setLabel(" e ")
                ->setBelongsTo("tx2");

        $f2 = new Zend_Form_SubForm();
        $f2->addElements([$tx2mark, $tx2]);

        $this->addSubForm($f2, "tx2");
        //$this->addElements([$tx1, $tx2, $tx1mark, $tx2mark]);

        // SNR
        $f3 = new Zend_Form_SubForm();

        $snr1mark = new Zend_Form_Element_Select("mark");
        $snr1mark->setBelongsTo("snr1");
        $snr1mark->setMultiOptions(array("=", ">=", "<=", "<", ">"));

        $snr1 = new Zend_Form_Element_Text("value");
        $snr1->setLabel("Entre ")
                ->setBelongsTo("snr1");

        $f3->addElements([$snr1mark, $snr1]);

        $this->addSubForm($f3, "snr1");

        $f4 = new Zend_Form_SubForm();

        $snr2mark = new Zend_Form_Element_Select("mark");
        $snr2mark->setBelongsTo("snr2");
        $snr2mark->setMultiOptions(array("=", ">=", "<=", "<", ">"));

        $snr2 = new Zend_Form_Element_Text("value");
        $snr2->setLabel(" e ")
                ->setBelongsTo("snr2");

        $f4->addElements([$snr2mark, $snr2]);
        $this->addSubForm($f4, "snr2");
        //$this->addElements([$snr1, $snr2, $snr2mark, $snr1mark]);

        // RX
        $f5 = new Zend_Form_SubForm();

        $rx1mark = new Zend_Form_Element_Select("mark");
        $rx1mark->setBelongsTo("rx1");
        $rx1mark->setMultiOptions(array("=", ">=", "<=", "<", ">"));

        $rx1 = new Zend_Form_Element_Text("value");
        $rx1->setLabel("Entre ")
                ->setBelongsTo("rx1");

        $f5->addElements([$rx1mark, $rx1]);
        $this->addSubForm($f5, "rx1");

        $f6 = new Zend_Form_SubForm();

        $rx2mark = new Zend_Form_Element_Select("mark");
        $rx2mark->setBelongsTo("rx2");
        $rx2mark->setMultiOptions(array("=", ">=", "<=", "<", ">"));
        $rx2 = new Zend_Form_Element_Text("value");
        $rx2->setLabel(" e ")
                ->setBelongsTo("rx2");

        $f6->addElements([$rx2mark, $rx2]);
        $this->addSubForm($f6, "rx2");
        //$this->addElements([$rx1, $rx2, $rx1mark, $rx2mark]);

        // MR

        $f7 = new Zend_Form_SubForm();

        $mr1mark = new Zend_Form_Element_Select("mark");
        $mr1mark->setBelongsTo("mr1");
        $mr1mark->setMultiOptions(array("=", ">=", "<=", "<", ">"));

        $mr1 = new Zend_Form_Element_Text("value");
        $mr1->setLabel("Entre ")
                ->setBelongsTo("mr1");

        $f7->addElements([$mr1, $mr1mark]);
        $this->addSubForm($f7, "mr1");

        $f8 = new Zend_Form_SubForm();

        $mr2mark = new Zend_Form_Element_Select("mark");
        $mr2mark->setBelongsTo("mr2");
        $mr2mark->setMultiOptions(array("=", ">=", "<=", "<", ">"));

        $mr2 = new Zend_Form_Element_Text("value");
        $mr2->setLabel(" e ")
                ->setBelongsTo("mr2");
        $f8->addElements([$mr2, $mr2mark]);
        $this->addSubForm($f8, "mr2");
        //$this->addElements([$mr1, $mr2, $mr1mark, $mr2mark]);

        $mac = new Zend_Form_Element_Text("macaddr");
        $mac->addPrefixPath('DM_Filter', APPLICATION_PATH . '/filters/', 'filter')
        ->addFilter("CleanMacAddress");
        $this->addElement($mac);

        $ipaddr = new Zend_Form_Element_Text("ipaddr");
        $this->addElement($ipaddr);

        $node = new Zend_Form_Element_Text("node");
        $this->addElement($node);

        $date1 = new Zend_Form_Element_Text("data1");
        $date1->setLabel("data1");
        $this->addElement($date1);

        $date2 = new Zend_Form_Element_Text("data2");
        $date2->setLabel("data2");
        $this->addElement($date2);
    }
}
