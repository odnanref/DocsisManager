<?php

class DM_Zend_View_Helper_FlashMessages extends Zend_View_Helper_Abstract
{

    public function flashMessages()
    {
        $helper = Zend_Controller_Action_HelperBroker::getStaticHelper('FlashMessenger');
        
        $messages = array_merge(
                $helper->getMessages(), 
                $helper->getCurrentMessages()
        );

        $helper->clearCurrentMessages();
        
        $output = '';

        if (!empty($messages) && is_array($messages)) {
            $output .= '<img src="/img/stop.png" alt="hide message box" onClick="hideMessage();"
                style="float: right;" width="14" height="14" id="btmessagesclose">';
            $output .= '<ul id="messages" style="list-style: none;">';
            foreach ($messages as $k => $message) {
                $output .=
                        '<li class="' . key($message) . '">' . current($message) . '</li>';
            }
            $output .= '</ul>';
        }

        return $output;
    }
    
}