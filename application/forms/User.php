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
 *
 * @author andref
 * @version $Id$
 *
 */
class DM_Form_User extends Zend_Form
{

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

    /**
     * Constructor
     *
     * @param  array|Zend_Config|null $options
     * @return void
     */
    public function __construct($options = null)
    {
        if (($options instanceof Far_Access_User) === true) {
            $this->setdata($options);
        }
        parent::__construct($options);
    }

    public function init()
    {
        $this->setMethod('post');
        $this->setName("userform");

        $this->addSubForm($this->userinfo(), 'userinfo')
//                ->addSubForm($this->acesso(), 'acessos')
//                ->addSubForm($this->aparelho(), 'aparelho')
        ;
        $sb = new Zend_Form_Element_Submit("gravar");
        $sb->setName("gravar");
        $sb->setLabel("Gravar");
        $this->addElement($sb);
    }

    public function userinfo()
    {
        $form = new Zend_Form_SubForm();
        $form->setAttribs(array(
            'name' => 'textboxtab',
            'legend' => 'Utilizador'
                )
        );

        $eid = new Zend_Form_Element_Hidden("idacuser");
        $eid->setValue($this->getdata("idacuser"));
        $form->addElement($eid);

        $elogin = new Zend_Form_Element_Text("login");
        $elogin->setLabel("Login");
        $elogin->setValue($this->getdata("login"))
                ->setRequired(true)
//				->addValidators(array('NotEmpty', true))
        ;
        $form->addElement($elogin);

        $elogin1 = new Zend_Form_Element_Password("password");
        $elogin1->setLabel("Password");
        $elogin1->setValue($this->getdata("senha"))
        //->setRequired(true)
//				->addValidators(array('NotEmpty', true))
        ;
        $form->addElement($elogin1);

        $elogin1_2 = new Zend_Form_Element_Password("confirmarpassword");
        $elogin1_2->setLabel("Confirmar Password");
//		$elogin1_2->addValidators(array('NotEmpty', true));
        $form->addElement($elogin1_2);

        $elogin2 = new Zend_Form_Element_Text("nome");
        $elogin2->setLabel("Nome");
        $elogin2->setValue($this->getdata("nome"));
        $form->addElement($elogin2);

        $elogin3 = new Zend_Form_Element_Text("email");
        $elogin3->setLabel("E@mail");
        $elogin3->setValue($this->getdata("email"));
        $form->addElement($elogin3);

        $estado = new Zend_Form_Element_Select("estado");
        $estado->setLabel("Estado")
                ->setRequired(true)
//				->addValidators(array('NotEmpty', true))
        ;
        $estado->addMultiOptions(array(
            'activo' => 'Activo',
            'inactivo' => 'Inactivo')
        );

        $form->addElement($estado);

        return $form;
    }

    public function acesso()
    {
        $form = new Zend_Form_SubForm();
        $form->setAttribs(array(
            'name' => 'acessos',
            'legend' => 'Permiss&otilde;es'
        ));

        $e = new Zend_Form_Element_Text("teste");
        $e->setLabel("teste");
        $form->addElement($e);

        return $form;
    }

}
