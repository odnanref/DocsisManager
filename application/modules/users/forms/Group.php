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
 * Description of Group
 *
 * @author andref
 * @version $Id$
 */
class Users_Form_Group extends Zend_Dojo_Form
{
    public function init()
    {
        parent::init();
        
        $this->setName("group");
        $this->setAction("/users/group/v");
        $this->setMethod("post");
                
        $id = new Zend_Form_Element_Hidden("idacgroup");
        $id->clearDecorators();
        
        $this->addElement($id);
        
        $name = new Zend_Dojo_Form_Element_TextBox("name");
        $name->setLabel("Nome");
        $name->setRequired();
        $this->addElement($name);
        
        $admin_id = new Zend_Dojo_Form_Element_ComboBox("admin_id");
        $admin_id->setLabel("Gestor do grupo");
        $this->addElement($admin_id);
        
        $bt = new Zend_Dojo_Form_Element_SubmitButton("go");
        $bt->setIgnore(true);
        $bt->setLabel("Guardar");
        
        $this->addElement($bt);
    }
}
