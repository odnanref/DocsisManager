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
 * User Form
 *
 * @author andref
 * @version $Id$
 */
class Users_Form_User extends Zend_Dojo_Form
{
    public function init()
    {
        parent::init();

        $this->setMethod("post");
        $this->setName("userinfo");
        $this->setIsArray(true);

        $this->setAction("add");
        $Els = array();

        $name = new Zend_Dojo_Form_Element_TextBox("name");
        $name->setLabel("Nome");
        $Els[] = $name;

        $login = new Zend_Dojo_Form_Element_TextBox("login");
        $login->setRequired(true);
        $login->setLabel("Login");
        $Els[] = $login;

        $senha = new Zend_Dojo_Form_Element_PasswordTextBox("senha");
        $senha->setLabel("Password");
        $senha->setRequired(true);
        $Els[] = $senha;

        $senha = new Zend_Dojo_Form_Element_PasswordTextBox("senha2");
        $senha->setLabel("Password");
        $senha->setRequired(true);
        $senha->setIgnore(true);
        $Els[] = $senha;

        $mail = new Zend_Dojo_Form_Element_TextBox("email");
        $mail->setLabel("E-mail");
        $Els[] = $mail;

        $state = new Zend_Dojo_Form_Element_FilteringSelect("state");
        $state->setMultiOptions(array("active" => "Activo", "unactive" => "Inactivo"));
        $state->setLabel("Estado");
        $Els[] = $state;

        $sub = new Zend_Dojo_Form_Element_SubmitButton("record");
        $sub->setLabel("Gravar");
        $sub->setIgnore(true);
        $Els[] = $sub;

        $this->addElements( $Els );
    }
}
