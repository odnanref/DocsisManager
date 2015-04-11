<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

use \Symfony\Component\EventDispatcher\Event;

/**
 * to be aware of actions made on CM
 *
 * @author andref
 * @version $Id$
 */
class DM_Service_DocsismodemEvent extends Event
{
    /**
     *
     * @var DM_Model_Docsismodem
     */
    private $dm = null;

    public function getDocsismodem()
    {
        return $this->dm;
    }

    public function __construct(DM_Model_Docsismodem $dm)
    {
        $this->dm = $dm;
    }
}
