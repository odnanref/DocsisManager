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
 * Description of Clientsearch
 * 
 * Form to input data for a client search
 *
 * @author andref
 * @version $Id$
 */
class Client_Form_Clientsearch extends Zend_Dojo_Form
{
    public function init()
    {
        $this->setAttribs(array(
            'name' => 'clientsearch',
            'legend' => 'Procurar cliente'
        ));
        $this->setIsArray(true);
        
        $this->setMethod("post");
        
        $md = new Zend_Dojo_Form_Element_TextBox("name");
        $md->setLabel("Nome");
        
        $mu = new Zend_Dojo_Form_Element_TextBox("phone");
        $mu->setLabel("Telefone");
        
        $fn = new Zend_Dojo_Form_Element_TextBox("email");
        $fn->setLabel("E-mail");
        
        $node = new Zend_Dojo_Form_Element_TextBox("node");
        $node->setLabel("Celula");
        
        $mac = new Zend_Dojo_Form_Element_TextBox("macaddr");
        $mac->setLabel("Mac");
        
        $this->addElements(array($md, $mu, $fn, $node, $mac));
        
        $fg = new Zend_Dojo_Form_Element_SubmitButton("search");
        $fg->setLabel("Procurar");     
        $fg->setIgnore(true);
        
        $this->addElement($fg);
    }
}
