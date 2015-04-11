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

use Symfony\Component\EventDispatcher\Event;

/**
 *
 * @author andref
 *
 */
class DocsismodemController extends Zend_Controller_Action implements Zend_Acl_Resource_Interface
{

    protected $DocsisConfig = array();

    public function preDispatch()
    {
        $bootstrap = $this->getInvokeArg("bootstrap");
        $aConfig = $bootstrap->getOptions();

        $this->DocsisConfig = array(
            "snmpread"          => $aConfig["docsis"]["snmpread"],
            "snmpwrite"         => $aConfig["docsis"]["snmpwrite"],
            "swupgradeserver"   => $aConfig["docsis"]["swupgradeserver"],
            "voipserver"        => array($aConfig["docsis"]["voipserver"])
        );
        parent::preDispatch();
    }

    public function getResourceId()
    {

    }
    /**
     *
     * @var Far_Resource_EventDispatcher
     */
    private $_dispatcher = null;

    public function getEventManager()
    {
        $bootstrap = $this->getInvokeArg('bootstrap');
        if ($this->_dispatcher === null ) {
            $this->_dispatcher = $bootstrap->getResource('Far_Resource_EventDispatcher');
        }
        return $this->_dispatcher;
    }

    public function init()
    {
        Zend_Dojo::enableView($this->view);
        $this->getEventManager();
    }

    public function indexAction()
    {
        $dms    = new DM_Model_Docsismodems();
        $models = new DM_Model_Model();

        $activos = $dms->getActivos();
        if ($activos !== null) {
            $activos = $activos->count();
        }

        $cut = $dms->fetchAll("estado='cortado'");
        if ($cut !== null) {
            $cut = $cut->count();
        }

        $unactive = $dms->fetchAll("estado='anulado'");
        if ($unactive !== null) {
            $unactive = $unactive->count();
        }

        $this->view->totalCmsActive = (int) $activos;
        $this->view->totalCmsUnactive = (int) $unactive;
        $this->view->totalCmsCut = (int) $cut;
        $this->view->totalCms =
                (int) ( (int) $activos + (int) $unactive + (int) $cut);
        $files      = $dms->getFilesInUse();
        $cmModels   = $models->getCountModels();

        $this->view->files = $files;
        $this->view->cmmodels = $cmModels;
        $this->view->moreRegs = $dms->getMoreRegs();

        $this->view->totalvoipActivo    = $dms->getAllVoip("activo")->count();
        $this->view->totalvoipOff       = $dms->getAllVoip("inactivo")->count();
        $this->view->perCellCount        = $dms->getPerCellCount();
    }

    public function getajaxAction()
    {
        $rhttp = new Zend_Controller_Request_Http();
        $estado = $rhttp->getQuery("estado");

        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $dm = new DM_Model_Docsismodems();
        if ($estado === null || $estado == 'activos') {
            $result = $dm->getActivos();
        } else {
            $result = $dm->getInactivos();
        }

        $data = new Zend_Dojo_Data('macaddr', $result->toArray());
        $data->setMetadata("totalCount", $result->count());
        print $data->toJson();
    }

    public function verAction()
    {
        $dms    = new DM_Model_Docsismodems();
        $dm     = null;
        $mac    = $this->_getParam("id");

        if ($mac > 0 ) {
            $mac = str_replace(":", "", $mac);
            $mac = str_replace(".", "", $mac);

            $dm = $dms->getById($mac);
        }

        $this->view->id = $mac;

        $files = array( 0 => '');
        foreach ($dms->getFilesInUse(2) as $file ) {
            $files[$file["config_file"]] = $file["config_file"];
        }

        $brand = new DM_Model_Brand();
        $form = new DM_Form_DojoDocsismodem(array(
            'brands'    => $brand->fetchAll(),
            'macaddr'   => $mac,
            'configfiles'   => $files
                ));

        if (count($_POST) > 0 && $form->isValid($_POST)) {
            $mac = $form->getSubForm("main")->getSubForm("Docsismodem")->getValue("macaddr");

            if (empty($mac) || $dm === null) {
                $dm = new DM_Model_Docsismodem();
            }
            $main = $form->getSubForm("main");

            $dados = array();
            $dados = array_merge($dados, $main->getSubForm("servico")->getValues(true));
            $dados = array_merge($dados, $main->getSubForm("aparelho")->getValues(true));
            $dados = array_merge($dados, $main->getSubForm("mta")->getValues(true));
            $dados = array_merge($dados, $main->getSubForm("Docsismodem")->getValues(true));

            $dm->setFromArray($dados);
            try {
                $id = $dm->save();
            } catch (Exception $ex ) {
                $id = -1;
                $this->_helper->flashMessenger->addMessage(
                        array('error'=> $ex->getMessage())
                        );
            }

            if ($id > 0) {
                $this->_dispatcher->dispatch(
                    "docsismodem.update", new DM_Service_DocsismodemEvent($dm)
                        );
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('warning'=>'Falha a guardar dados.')
                        );
            }

        } else {
            if (!empty($mac)) {
                $dm = $dms->getById($mac);
            } else {
                $dm = new DM_Model_Docsismodem();
            }

            if (count($_POST) > 0) {
                $form->setDefaults($_POST);
            }
        }

        if ($dm !== null ) {
            $arr = $dm->toArray();
            $model = new DM_Model_Model();
            $row = $model->fetchRow("idmodel = " . (int) $dm->idmodel);

            if ($row !== null ) {
                $arr['brand'] = $row->idbrand;
                $form->setModelOptions($row->idbrand);
            }

            $form->setDefaults($arr);
        }

        $this->view->form = $form;

        $this->view->formLeaseQuery = new DM_Form_LastRegisted(array('macaddr' => $mac));
        $rxtx = new DM_Form_LastRegisted(array('macaddr' => $mac));
        $rxtx->toRxTx();
        $this->view->formrxtx = $rxtx;
        $this->view->formRemoteQuery = new DM_Form_RemoteQuery(array('macaddr' => $mac));

        if ($mac > 0) {
            $dmsignal = new DM_Model_DocsisSignal();
            $Signal = $dmsignal->get($mac);
            if ($Signal !== null) {
                $data = new Zend_Dojo_Data("idtx", $Signal->toArray());
                $r = $data->toJson();
                $this->view->Signal = (!empty($r) ? $r : "[]");
            }
        }

        $this->render("vlayout");
    }

    public function addAction()
    {
        $dms = new DM_Model_Docsismodems();
        $brand = new DM_Model_Brand();

        $files = array( 0 => '');
        foreach ($dms->getFilesInUse(2) as $file ) {
            $files[$file["config_file"]] = $file["config_file"];
        }

        $form = new DM_Form_DMAdd(array(
            'brands'    => $brand->fetchAll(),
            'configfiles'   => $files
                ));

        if (count($_POST) > 0 && $form->isValid($_POST)) {
            $dm = new DM_Model_Docsismodem();
            $dados = array();
            $dados = array_merge($dados, $form->getSubForm("docsismodem")->getValues(true));
            $dados = array_merge($dados, $form->getSubForm("mta")->getValues(true));
            $dados = array_merge($dados, $form->getSubForm("servico")->getValues(true));
            $dados = array_merge($dados, $form->getSubForm("aparelho")->getValues(true));
            $dm->setFromArray($dados);

            try {
                $id = $dm->save();
            } catch (Exception $ex ) {
                $id = -1;
                $this->_helper->flashMessenger->addMessage(
                        array('error'=> $ex->getMessage())
                        );
            }

            if ($id > 0 ) {
                $this->_dispatcher->dispatch(
                    "docsismodem.new", new DM_Service_DocsismodemEvent($dm)
                        );
                $this->_helper->flashMessenger->addMessage(
                        array('success'=>'Sucesso a guardar dados.')
                        );
                $this->_redirect("/docsismodem/ver/id/".$dm->macaddr);
            } else {
                $this->_helper->flashMessenger->addMessage(
                        array('error'=>'Falha a guardar dados.')
                        );
            }
        }

        $this->view->form = $form;

        $this->render("form", null, true);
    }

    public function inactivosAction()
    {
        $model = new DM_Model_Model();
        $resModels = $model->getAll();
        $form = new DM_Form_Docsismodem(
                array('models' => $resModels )
                );
        $this->view->procura    = $form;
        $this->view->estado     = "inactivos";
        $this->render("list");
    }

    public function searchAction()
    {
        $model = new DM_Model_Model();
        $resModels = $model->getAll();
        $form = new DM_Form_Docsismodem(
                array('models' => $resModels )
                );
        $this->view->form = $form;
        $this->view->procura = $form;

        if (count($_POST) > 0 && $form->isValid($_POST)) {
            $dms = new DM_Model_Docsismodems();
            $q1 = array();

            if (!empty($_POST['Docsismodem']['macaddr'])) {
                $q1['macaddr'] =
                str_replace(".", "",$_POST['Docsismodem']['macaddr']);
                $q1['macaddr'] = str_replace(":", "", $q1['macaddr']);
                $q1['macaddr'] = str_replace("-", "", $q1['macaddr']);
            }

            if (!empty($_POST['Docsismodem']['serialnum'])) {
                $q1['serialnum'] = $_POST['Docsismodem']['serialnum'];
            }

            if (!empty($_POST['Docsismodem']['ipaddr'])) {
                $q1['ipaddr'] = $_POST['Docsismodem']['ipaddr'];
            }

            if (!empty($_POST['Docsismodem']['estado'])) {
                $q1['estado'] = $_POST['Docsismodem']['estado'];
            }

            if (!empty($_POST['Docsismodem']['config_file'])) {
                $q1['config_file'] = $_POST['Docsismodem']['config_file'];
            }

            if (!empty($_POST['Docsismodem']['phone'])) {
                $q1['phone'] = $_POST['Docsismodem']['phone'];
            }

            if (!empty($_POST['Docsismodem']['idmodel'])) {
                $q1['idmodel'] = $_POST['Docsismodem']['idmodel'];
            }

            if (!empty($_POST['Docsismodem']['node'])) {
                $q1['node'] = $_POST['Docsismodem']['node'];
            }

            if (count($q1) > 0) {
                $r = $dms->search($q1);

                $data = new Zend_Dojo_Data('macaddr', $r->toArray());
                $data->setMetadata("totalCount", $r->count());
                $this->view->resultado = $data->toJson();

                $this->view->estado = null;
                $this->render("list");

                return true;
            }
        }
    }

    public function viewAction()
    {
        $Res    = null;
        $dms    = new DM_Model_Docsismodems();

        $model = new DM_Model_Model();
        $resModels = $model->getAll();
        $form = new DM_Form_Docsismodem(
                array('models' => $resModels )
                );
        $this->view->procura = $form;

        foreach ($this->_getAllParams() as $k => $v ) {
            switch ($k) {
                case 'idmodel':
                    $Res = $dms->fetchAll("idmodel = " .
                            (int) $this->_getParam("idmodel", 0));
                    break;
                case 'config_file':
                    $str = urldecode($this->_getParam("config_file", 0));
                    $Res = $dms->search(["config_file" => $str ]);
                    break;
                case 'cell':
                    $str = urldecode($this->_getParam('cell'));
                    $Res = $dms->search(['node' => $str]);
                    break;
            }
        }

        if ($Res !== null ) {
            $data = new Zend_Dojo_Data('macaddr', $Res->toArray());
            $data->setMetadata("totalCount", $Res->count());
            $this->view->resultado = $data->toJson();
        } else {
            $this->view->resultado = "[]";
        }
        $this->view->estado = null;
        $this->render("list");

        return true;
    }

    public function getlastleaseAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $mac = $this->_getParam("id", 0);
        $date = $this->_getParam("date", date("Y-m-d"));

        if ($mac <= 0) {
            return null;
        }
        $dat = explode("/", $date);
        if (count($dat) > 0) {
            $date = $dat[2] . "-" . $dat[1] . "-" . $dat[0];
        }
        $dms = new DM_Model_Docsismodems();
        $Leases = $dms->getCMLastACKByDate(new DateTime($date), $mac);
        if ($Leases !== null) {
            $data = new Zend_Dojo_Data("idlease", $Leases->toArray());
            $data->setMetadata("totalCount", $Leases->count());
            print $data->toJson();
        } else {
            $data = new Zend_Dojo_Data("idlease", array());
            print $data->toJson();
        }
    }

    public function getremotequeryAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $mac = $this->_getParam("id", 0);

        if ($mac <= 0) {
            return;
        }

        $dms = new DM_Model_Docsismodems();
        $dm = $dms->getById($mac);
        $Res = $dm->remoteQuery();
        $Res = array(
            'mac' => $mac
            , 'tx' => $Res['tx']
            , 'rx' => $Res['rx']
            , 'snr' => $Res['snr']
            , 'microreflections' => $Res['microreflections']
            , 'version' => $Res['version']
            , 'imagefile' => $Res['imagefile']
            , 'downstreamfreq' => $Res['downstreamfreq']
            , 'upstreamfreq' => $Res['upstreamfreq']
            , 'uptime' => trim($Res['uptime'])
            , 'log' => $Res['log']
            , 'detailInfo' => $dm->getremoteDetailInfo()
        );

        print json_encode($Res);
    }

    public function gettxrxAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $mac = $this->_getParam("id", 0);

        $date = $this->_getParam("date");

        $date = urldecode($date);

        $dat = explode("/", $date);
        if (count($dat) > 2) {
            $date = $dat[2] . "-" . $dat[1] . "-" . $dat[0];
        } else {
            $this->_response->setHttpResponseCode(412);
            $this->_response->setBody(json_encode("Failed: missing data"));
            return null;
        }

        if ($mac <= 0) {
            return null;
        }

        $dms = new DM_Model_Docsismodems();
        $Leases = $dms->getCMLastRXByDate(new DateTime($date), $mac);
        if ($Leases !== null) {
            $data = new Zend_Dojo_Data("idtx", $Leases->toArray());
            $data->setMetadata("totalCount", $Leases->count());
            print $data->toJson();
        }
    }

    public function genfileAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $filename = null;
        $macaddr = $this->_getParam("id");
        $erros = array();
        $reply = array();

        if (trim($macaddr) == '') {
            $erros[] = "Mac Addr especificado é inválido.";
        }

        $dm = new DM_Model_Docsismodems();
        if ($dm->validarMac($macaddr) === false) {
            $erros[] = "Mac Addr especificado é inválido.";
        }

        $request = $this->getRequest();

        $body = $request->getRawBody();
        if (empty($body)) {
            $erros[] = "Sem dados para processar pedido.";
        }

        $a = Zend_Json_Decoder::decode($body);
        if (array_key_exists("up", $a)) {
            $up = (double) $a['up'];
            if ($up <= 0) {
                $erros[] = "Velocidade de upload igual ou inferior a zero.";
            }
        } else {
            $erros[] = "Sem velocidade de upload.";
        }

        if (array_key_exists("down", $a)) {
            $down = (double) $a['down'];
            if ($down <= 0) {
                $erros[] = "Velocidade de download igual ou inferior a zero.";
            }
        } else {
            $erros[] = "Sem velocidade de download.";
        }

        if (count($erros) <= 0) {
            if (array_key_exists("filename", $a)) {
                $filename = $a['filename'];
                if (empty($filename)) {
                    $reply[] = "Sem nome de ficheiro ou nome vazio.\nApenas importante se MTA.";
                }
            } else {
                $reply[] = "Sem nome de ficheiro. Apenas importante se for um MTA.";
            }

            $dms = new DM_Model_Docsismodems();
            try {
                $r = $dms->genFile($macaddr, $up."M", $down."M", $filename, $this->DocsisConfig);
                if ($r === false ) {
                    $erros[] = "An error ocurred.";

                }
            } catch (Exception $e) {
                $erros[] = $e->getMessage();
            }
        }

        if (count($erros) > 0) {
            $tmp = '';
            foreach ($erros as $erro) {
                $tmp .= "\n$erro\n";
            }
            $this->getResponse()->setHttpResponseCode(406);
            $this->getResponse()->setBody($tmp);
            return null;
        }

        if (count($reply) > 0 ) {
            $tmp = '';
            foreach ($reply as $r) {
                $tmp .= "\n$r\n";
            }
            $this->getResponse()->setBody($tmp);
        }
    }

    public function listAction()
    {
        $model = new DM_Model_Model();
        $resModels = $model->getAll();
        $form = new DM_Form_Docsismodem(
                array('models' => $resModels )
                );
        $this->view->procura = $form;
    }

    public function exporttocsvAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        if (count($_POST) > 0 && array_key_exists("exp", $_POST)) {
            $time = time();
            header("Pragma: public");
            header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
            header("Content-type: application/csv");
            header("Content-Disposition: attachment; filename=\"grid_$time.csv\"");
            $exportedData = $_POST['exp'];
            echo $exportedData;
        }
    }

    public function getnewbymonthsAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $year = $this->_getParam("year", date("Y"));

        $dms = new DM_Model_Docsismodems();
        $Leases = $dms->getTotalActiveByMonth($year);

        if ($Leases !== null && $Leases->count() > 0) {
            $tmp = array();
            $data = array(
                'identifier' => 'first_online',
                'label' => 'first_online',
                'items' => array()
            );

            $data["items"] = $Leases->toArray();

            print json_encode($data, JSON_NUMERIC_CHECK);
            return true;
        }
        print json_encode(array());
    }

    public function getnewbymonthsnetworkAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $year = $this->_getParam("year", date("Y"));
        $network = addslashes($this->_getParam("network", null));

        $dms = new DM_Model_Docsismodems();
        $Leases = $dms->getTotalActiveByMonthByNetwork($year, $network);

        if ($Leases !== null && $Leases->count() > 0) {
            $tmp = array();
            $data = array(
                'identifier' => 'first_online',
                'label' => 'first_online',
                'items' => array()
            );

            $data["items"] = $Leases->toArray();

            print json_encode($data, JSON_NUMERIC_CHECK);
            return true;
        }
        print json_encode(array());
    }

    public function cmresetAction()
    {
        $this->_helper->layout->disableLayout();
        $this->getHelper('viewRenderer')->setNoRender(true);

        $id = $this->_getParam("id", null);
        if ($id === null) {
            $this->getResponse()->setHttpResponseCode(406);
            $this->getResponse()->setBody("Failed to get macaddress");
            return false;
        }

        $dms = new DM_Model_Docsismodems();
        $dm = $dms->getById($id);
        if ($dm === null) {
            $this->getResponse()->setHttpResponseCode(406);
            $this->getResponse()->setBody("Failed to find CM in DB");
            return false;
        }

        $dm->cmreset();

        $this->getResponse()->setHttpResponseCode(202);
        $this->getResponse()->setBody("CM reset done");
        return true;
    }
}
