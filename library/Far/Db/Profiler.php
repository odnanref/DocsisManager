<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Profiler
 *
 * @author andref
 */
class Far_Db_Profiler extends Zend_Db_Profiler
{

    protected $_lastQueryText;
    protected $_lastQueryType;

    public function queryStart($queryText, $queryType = null)
    {
        $this->_lastQueryText = $queryText;
        $this->_lastQueryType = $queryType;

        return null;
    }

    public function queryEnd($queryId)
    {
        return;
    }

    public function getQueryProfile($queryId)
    {
        return null;
    }

    public function getLastQueryProfile()
    {
        $queryId = parent::queryStart($this->_lastQueryText, $this->_lastQueryType);

        return parent::getLastQueryProfile();
    }

}
