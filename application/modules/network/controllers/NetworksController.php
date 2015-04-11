<?php

/**
 * Network management controller
 *
 * @author andref
 *
 */
class Network_NetworksController extends Zend_Controller_Action
{

    public function init()
    {
        Zend_Dojo::enableView($this->view);
    }
    
    public function getajaxAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $dm = new Network_Model_Networks();
        $result = $dm->fetchAll();

        $data = new Zend_Dojo_Data('netid', $result->toArray());
        print $data->toJson();
    }

    public function listAction()
    {
        // All Javascript
    }

    public function saveAction()
    {
        $net = new Network_Model_Networks();
        //

        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);
        $request = $this->getRequest();

        $body = $request->getRawBody();
        if (empty($body)) {
            return null;
        }
        $net->getAdapter()->beginTransaction();

        $r = $net->delete("1=1");
        $a = Zend_Json_Decoder::decode($body, "Network_Model_Network");

        foreach ($a->items as $network) {
            if ($network->netid > 0) {
                $network->toSave();
            } else {
                $network->netid = null;
            }
            $netid = $network->save();
            if ($netid <= 0 ) {
                $net->getAdapter()->rollBack();
                return $this->_response->appendBody("FAILED ROLLBACK CALLED");
            }
        }

        $net->getAdapter()->commit();
    }

    public function testAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $dm = new Network_Model_Networks();
        $result = $dm->fetchAll();

        $data = new Zend_Dojo_Data('netid', $result->toArray());
        print $data->toJson();
        $a = Zend_Json_Decoder::decode($data->toJson(), "Network_Model_Network");
        var_dump($a);
    }

}
