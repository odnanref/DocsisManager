<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of DataGrid
 *
 * @author andref
 * @version $Id$
 */
class Zend_View_Helper_DataGridHtml
{
    private $_nameDG       = 'DefaultSt';
    
    private $_action     = '';
    
    private $_key        = '';
    
    private $_selectMode = "single";
    
    private $_fields     = array();
    
    private $_storage   = 'getall/';
    
    public function dataGrid($key, $action = null, $options = array() )
    {
        
        if (count($options) > 0 ) {
            if (array_key_exists("selectmode", $options)) {
                $this->_selectMode = $options['selectmode'];
            } elseif (array_key_exists("fields", $options)) {
                if (!is_array($options['fields'])) {
                    throw new Exception("fields is not an array");
                }
                $this->_fields = $options['fields'];
            } elseif(array_key_exists("selectmode", $options)) {
                $this->_selectMode = $options['selectmode'];
            } elseif(array_key_exists("storage", $options)) {
                    $this->_storage = $options['storage'];
            }
        }
        
        if ($action !== null ) {
            $this->_action = $action;
        }
        
        if ($key === null ) {
            throw new Exception("Key cannot be null.");
        }
        
        $this->_key = $key;
        
        return $this->_init();
    }
    
    private function _init()
    {
        $str = '';
        if (!empty($this->_action)) {
            $str .= $this->addJS();
        }
        
        $str .= $this->storageType();
        
        $str .= $this->draw();
        
        return $str;
    }
    /**
     * Returns double click handler to direct to a form
     * 
     * @return String
     */
    public function addJS()
    {
        $str = "<script type=\"text/Javascript\">\n";
        $str .= "function pickit(event)\n";
        $str .= "{\n";
        $str .= "grid = dijit.byId('grid".$this->_key."');\n";
    	$str .= "selected_index = grid.focus.rowIndex;\n";
    	$str .= "selected_item = grid.getItem(selected_index);\n";
    	//Not sure if this is the most efficient way but it worked for me
    	$str .= "selected_id = grid.store.getValue(selected_item, \"".$this->_key."\");\n";
    	$str .= "location.href = " . $this->_action . "+selected_id;\n";
        $str .= "}\n";
        $str .= "</script>\n";
        
        return $str;
    }
    
    public function storageType()
    {
        if (strpos($this->_storage, "[") !== false ) {
            $st = "jsonData".$this->_key . " = " . $this->_storage."\n";
            $st .= "<gett dojoType=\"dojo.data.ItemFileReadStore\" 
                jsId=\"jsonStore" . $this->_key . "\" 
                    data=\"jsonData" . $this->_key . "\" id=\"store" . $this->_key . "\" />";
        } else {
            $st = '<gett dojoType="dojo.data.ItemFileReadStore" jsId=\"jsonStore'.$this->_key.'" 
         url="' . $this->_storage . '" id="store'.$this->_key.'" />';
        }
        
        return $st;
    }
    
    public function draw()
    {
        $str = '';
        $str .= "<table dojoType=\"dojox.grid.DataGrid\" id=\"grid".$this->_key."\" jsid=\"gridJ".$this->_key."\" 
       query=\"{ " . $this->_key . ": '*' }\" store=\"jsonStore".$this->_key."\"
       selectionMode=\"" . $this->_selectMode . "\" autoWidth=\"true\"
       style=\"width: 100%; height: 400px\" onRowDblClick='pickit();'>\n";
        $str .= "<thead>\n";
        $str .= "<tr>\n";
        foreach ($this->_fields as $k => $v ) {
            $str .= "\t<th field=\"$k\">$v</th>\n";
        }
        $str .= "</tr>\n";;
        $str .= "</thead>\n";
        $str .= "</table>\n";
        
        return $str;
    }
        
}
