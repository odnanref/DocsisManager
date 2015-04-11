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
class Zend_View_Helper_DataGrid
{

    private $_nameDG = 'DefaultSt';
    private $_action = '';
    private $_key = '';
    private $_selectMode = "single";
    private $_fields = array();
    private $_storage = 'getall/';

    public function dataGrid($key, $options = array())
    {
        if (count($options) > 0) {

            if (array_key_exists("fields", $options)) {

                if (!is_array($options['fields'])) {
                    throw new Exception("fields is not an array");
                }
                $this->_fields = $options['fields'];
            }

            if (array_key_exists("selectmode", $options)) {
                $this->_selectMode = $options['selectmode'];
            }

            if (array_key_exists("storage", $options) && !empty($options['storage'])) {
                $this->_storage = $options['storage'];
            }

            if (array_key_exists("action", $options)) {
                $this->_action = $options['action'];
            }
        }

        if ($key === null) {
            throw new Exception("Key cannot be null.");
        }

        $this->_key = $key;
        $str = "<script type='text/Javascript'>\n
                function loadGrid_" . $this->_key . "() 
                {
                ";
        $str .= $this->_init();
        $str .= "}
            dojo.addOnLoad(loadGrid_" . $this->_key . ");
                loadGrid_" . $this->_key . "();
            </script>\n";

        return $str;
    }

    private function _init()
    {
        $options = '{';
        if (strpos($this->_storage, "{") === false && strpos($this->_storage, "[") === false) {
            $options .= " url: " . $this->_storage . ",";
        } else {
            $options .= "data: " . $this->_storage . ",";
        }

        $options .= "\n clearOnClose: true, urlPreventCache: true }";

        $str = '';
        $str .= "\n var store_" . $this->_key .
                " = new dojo.data.ItemFileReadStore( {$options});";

        // set the layout structure:
        $str .= "\n var layout_" . $this->_key . " = [";
        foreach ($this->_fields as $field => $title) {
            $str .= "{ field: '$field', name: '$title' },";
        }
        $str = substr($str, 0, (strlen($str)-1)) ;
        $str .= "];";

        // create a new grid:
        $str .= "
            var grid4_" . $this->_key . " = new dojox.grid.DataGrid({
        query: { " . $this->_key . ": '*' },
        store: store_" . $this->_key . ",
        clientSort: true,
        rowSelector: '20px',
        structure: layout_" . $this->_key . "
        }, document.createElement('store'));";

        // append the new grid to the div "gridContainer4_":
        $str .= "\ndojo.byId(\"gridContainer_" . $this->_key . "\").appendChild(grid4_" .
                $this->_key . ".domNode);
\n
        // Call startup, in order to render the grid:
  \n      grid4_" . $this->_key . ".startup();";

        return $str;
    }

}