<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * CleanMacAddress
 * removes some usually used separators in mac address
 *
 * @author andref
 * @version $Id$
 */
class DM_Filter_CleanMacAddress implements Zend_Filter_Interface
{
    public function filter($value)
    {
        $value = str_replace(":", "", $value);
        $value = str_replace(".", "", $value);
        $value = str_replace("-", "", $value);
        $value = trim($value);
        return $value;
    }
}
