<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Leasehistory
 *
 * @author andref
 */
class Network_LeaseController extends Zend_Controller_Action
{
    public function init()
    {
        Zend_Dojo::enableView($this->view);
    }

    public function searchresultAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $ip = $this->_getParam("id", null);
        if ($ip === null) {
            print json_encode(["No lease submited"]);
            return false;
        }

        $date = $this->_getParam("date", date("Y-m-d"));

        $d = new \DateTime();
        $d->createFromFormat("Y-m-d", $date);

        $lease = new Network_Model_Leases();
        $res = $lease->findLease($ip, $d);
        if ($res !== null) {
            $data = new Zend_Dojo_Data("idlease", $res->toArray());
            print $data->toJson();
        } else {
            print json_encode(["Empty result."]);
        }

        return false;
    }

    public function searchAction()
    {

    }
}
