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
 * Description of Privilege
 *
 * @author andref
 * @version $Id$
 */
class USers_Form_Privilege extends Zend_Dojo_Form
{
    private $Groups = array();
    
    public function __construct($options = null)
    {
        if (array_key_exists("groups", $options)) {
            $this->Groups = $options['groups']; // key value pair
        }
        parent::__construct($options);
    }
    
    public function init()
    {
        $this->setName("privilege");
        $this->setMethod("post");
        
        $id     = new Zend_Form_Element_Hidden("idprivilege");
        $id->clearDecorators();
        
        $mod    = new Zend_Dojo_Form_Element_TextBox("modulename");
        $mod->setLabel("Modulo");
        $mod->setRequired();
        
        $ctr    = new Zend_Dojo_Form_Element_TextBox("controllername");
        $ctr->setLabel("Pagina");
        $ctr->setRequired();
        
        $act    = new Zend_Dojo_Form_Element_TextBox("controlleraction");
        $act->setLabel("Opção");
        $act->setRequired();
        
        $group = new Zend_Dojo_Form_Element_FilteringSelect("idacgroup");
        $group->setMultiOptions($this->Groups);
        $group->setRequired();
//        $group->setAttrib("style", "height: 60px; width: 100px;");
//        $group->setAttrib("multiple", "multiple");
//        $group->setIsArray(true);
        
        $read   = new Zend_Dojo_Form_Element_CheckBox("r");
        $read->setLabel("Ler");
        
        $write  = new Zend_Dojo_Form_Element_CheckBox("w");
        $write->setLabel("Alterar");
        
        $del    = new Zend_Dojo_Form_Element_CheckBox("d");
        $del->setLabel("Eliminar");
        
        $s      = new Zend_Dojo_Form_Element_SubmitButton("record");
        $s->setLabel("Guardar");
        $s->setIgnore(true);
        
        $this->addElements(
                array($id, $mod, $ctr, 
                    $act, $group, $read,
                    $write, $del, $s
                    )
                );
    }
}
