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
 * Docsissignal
 * manage actions for the docsissignal table
 * 
 *
 * @author andref
 * @version $Id$
 */
class DocsissignalController extends Zend_Controller_Action 
{
    public function init()
    {
        
    }
    
    public function faillingAction()
    {
        
    }
    
    public function filterAction()
    {
        $res = null;
        
        $form = new DM_Form_Signalfilter();
        if (count($_POST) > 0 ) {
            if ( $form->isValid($_POST) ) {
                $ds = new DM_Model_DocsisSignal();
                $res = $ds->search($form->getValues(true));

//                $this->_helper->flashMessenger->addMessage(
//                        array('success'=>'Dados correctos para pesquisa.')
//                        );                
            } else  {
                $this->_helper->flashMessenger->addMessage(
                        array('failure'=>'Dados incorrectos para pesquisa.')
                        );
            }
            $form->setDefaults($_POST);
        }
        
        $this->view->resultado = "";
        
        if ($res === null ) {
            return false;
        }
        
        $data = new Zend_Dojo_Data("idtx", $res->toArray());
        $data->setMetadata("totalCount", $res->count());
        $this->view->resultado = $data->toJson();
        
        $this->render("failling");
    }
    
    public function getajaxAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);
        
        $dms = new DM_Model_DocsisSignal();
        $res = $dms->getFaulty();
        if ($res === null ) {
            return false;
        }
        
        $data = new Zend_Dojo_Data("idtx", $res->toArray());
        $data->setMetadata("totalCount", $res->count());
        print $data->toJson();
    }
}

