
//
// Control and Manage a provision ISP network
//
// Copyright (C) 2011 Fernando Ribeiro <netriver@gmail.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//


/***
 *
 * @author andref
 * @version $Id$
 *
 * Javascript functions
 *
 */

dojo.require("dojox.storage.LocalStorageProvider");
dojo.require("dojox.storage.GearsStorageProvider");
dojo.require("dojox.storage.BehaviorStorageProvider");
    //>>excludeStart("offlineProfileExclude", kwArgs.dojoxStorageBuildOption == "offline");
dojo.require("dojox.storage.WhatWGStorageProvider");
dojo.require("dojox.storage.FlashStorageProvider");
    //>>excludeEnd("offlineProfileExclude");
dojo.require("dojox.storage.CookieStorageProvider");

function hideMessage() {
    dojo.style("messages", 'display', 'none');
    dojo.style("btmessagesclose", 'display', 'none');
}

/*
 * Menu Code related
 **/
function listactivos()
{
    location.href = "/docsismodem/list/";
}

function listinactivos(){
    location.href = "/docsismodem/inactivos/";
}

function liststatic()
{
    location.href = "/networks/liststatic/";
}

function addstatic()
{
    location.href = "/networks/addstatic/";
}



function sair() {
    location.href   = "/users/user/logout/";
}

/*
 * Generate Menu
 **/
var pMenuBar;
dojo.addOnLoad(function() {
    pMenuBar = new dijit.MenuBar({});

    pMenuBar.addChild(new dijit.MenuBarItem({
        label: "Inicio, Autenticado como: " + dojo.cookie("username"),
        onClick: function () {
            location.href = "/";
        }
    }));

    var pSubMenu = new dijit.Menu({});
    var pSignalInfo = new dijit.Menu({});

    pSignalInfo.addChild(new dijit.MenuItem({
            label: "Filtrar",
            onClick: function(){
                location.href = "/docsissignal/filter";
            }
        })
    );

    pSignalInfo.addChild(new dijit.MenuItem({
            label: "Listar graves",
            onClick: function(){
                location.href = "/docsissignal/failling";
            }
        })
    );

    pSubMenu.addChild(new dijit.MenuItem({
        label: "Adicionar modem",
        onClick: function(){
            location.href = "/docsismodem/add/";
        },
        accelKey: "Shift+A"
    }));
    pSubMenu.addChild(new dijit.MenuItem({
        label: "Listar activos",
        onClick: listactivos,
        accelKey: "Shift+L"
    }));
    pSubMenu.addChild(new dijit.MenuItem({
        label: "Listar inactivos",
        onClick: listinactivos,
        accelKey: "Shift+I"
    }));

    pSubMenu.addChild(new dijit.MenuItem({
        label: "Procurar",
        onClick: function() {
            location.href = "/docsismodem/search/";
        }
    }));

    pSubMenu.addChild(new dijit.MenuItem({
        label: "Vista global",
        onClick: function() {
            location.href = "/docsismodem/";
        },
        accelKey: "Shift+I"
    }));

    pSubMenu.addChild(new dijit.MenuItem({
        label: "Inf. de sinal",
        popup: pSignalInfo
        })
    );

    pMenuBar.addChild(new dijit.PopupMenuBarItem({
        label: "Modems",
        popup: pSubMenu
    }));

    var pSubMenu2 = new dijit.Menu({});
/**
    pSubMenu2.addChild(new dijit.MenuItem({
        label: "Ver redes",
        onClick: function () {
            location.href = "/network/networks/list/";
        }
    }));

    // Endereco estatico
    var pStatic = new dijit.Menu({});
    pStatic.addChild(new dijit.MenuItem({
        label: "Listar",
        onClick: function () {
            location.href = "/network/static/list/";
        }
    }));

    pStatic.addChild(new dijit.MenuItem({
        label: "Adicionar",
        onClick: function () {
            location.href = "/network/static/add/";
        }
    }));

    pSubMenu2.addChild(new dijit.MenuItem({
        label: "Endere&ccedil;os est&aacute;ticos",
        popup: pStatic
    }));
*/

    pLease = new dijit.Menu({});
    pLease.addChild(new dijit.MenuItem({
        label: "Procurar IP",
        onClick: function () {
            location.href = "/network/lease/search/";
        }
    }));

    pSubMenu2.addChild(
        new dijit.MenuItem({label: "Leases", popup: pLease})
    );

    pMenuBar.addChild(new dijit.PopupMenuBarItem({
        label: "Rede IP",
        popup: pSubMenu2
    }));

    var submenuBrand = new dijit.Menu({});
    var submenuModel = new dijit.Menu({});

    submenuBrand.addChild(new dijit.MenuItem({
        label: "listar",
        onClick: function () {
                location.href = "/device/listbrand/";
            }
    }));

    submenuBrand.addChild(new dijit.MenuItem({
        label: "adicionar",
        onClick: function () {
            location.href = "/device/addbrand/";
        }
    }));

    submenuModel.addChild(new dijit.MenuItem({
        label: "listar",
        onClick: function () {
            location.href = "/device/listmodel/";
        }
    }));

    submenuModel.addChild(new dijit.MenuItem({
        label: "adicionar",
        onClick: function () {
            location.href = "/device/addmodel/";
        }
    }));

    var pSubMenu3 = new dijit.Menu({});

    pSubMenu3.addChild(new dijit.MenuItem({
        label: "Marcas",
        popup: submenuBrand
    }));

    pSubMenu3.addChild(new dijit.MenuItem({
        label: "Modelos",
        popup: submenuModel
    }));

    /*
    pSubMenu3.addChild(new dijit.MenuItem({
        label: "Equipamentos",
        popup: function () {
            new dijit.Menu({});
        }
    }));
    */
    pMenuBar.addChild(new dijit.PopupMenuBarItem({
        label: "Aparelhos",
        popup: pSubMenu3
    }));
/**
    var pSubMenu4 = new dijit.Menu({});

    pSubMenu4.addChild(new dijit.MenuItem({
        label: "Novo",
        onClick: function ()
                {
                    location.href = "/client/client/new/";
                }
    }));

    pSubMenu4.addChild(new dijit.MenuItem({
        label: "Procurar",
        onClick: function ()
                {
                    location.href = "/client/client/search/";
                }
    }));

    pSubMenu4.addChild(new dijit.MenuItem({
        label: "Listar",
        onClick: function ()
                {
                    location.href = "/client/client/list/";
                }
    }));

    pMenuBar.addChild(new dijit.PopupMenuBarItem({
        label: "Clientes",
        popup: pSubMenu4
    }));
*/
    pMenuBar.addChild(new dijit.MenuBarItem({
        label: "Sair",
        onClick: sair
    }));

    pMenuBar.placeAt("wrapper");
    pMenuBar.startup();
});

function loadModelo()
{
    var addresstmp = "/device/getmodel/?idbrand=" +
        dijit.byId('aparelho-brand').get('value');

    var dev = dojo.byId("aparelho-idmodel");
    var wid = dijit.byId(dev.id);
    var readStore = wid.store;
    /* modelo */
    readStore.clearOnClose = true;
    readStore.close();
    readStore.url = addresstmp;
    readStore.fetch();
    readStore.close();


}

/**
 * Handle form hide show of fields
 *
 * @param bx string
 */
function formclienteComboTel(bx)
{
    var a = dojo.byId("phone-" + bx).value;
    if (a != 0 ) {
        dojo.style('divme' + bx, {
            'display' : 'block'
        });
    } else {
        dojo.style('divme' + bx, {
            'display' : 'none'
        });
    }
}
/**
 * Handle form hide show of fields in net
 *
 * @param bx string
 */
function formclienteComboNet(bx)
{
    var b = dojo.byId("internet-" + bx).value;
    if (b != 0 ) {
        dojo.style('divmemac' + bx, {
            'display' : 'block'
        });
    } else {
        dojo.style('divmemac' + bx, {
            'display' : 'none'
        });
    }
}

function removerServico(type, id)
{
    if( confirm("Quer realmente anular o serviço?") ) {
        // delete it!
        var b = dojo.byId("service" + type + "-" + id + "-idservice").value;
        if (b > 0 ) {
            //location.href = "/service/remove/" + b;
            //The parameters to pass to xhrPost, the message,
            //and the url to send it to
            //Also, how to handle the return and callbacks.
            var unactive = dojo.byId("service" + type + "-" + id + "-dataunactive").value;
            var tmpunactive = {
                "dataunactive": unactive
            };

            var xhrArgs = {
                url: "/client/service/remove/id/" + b,
                postData: dojo.toJson(tmpunactive),
                handleAs: "json",
                headers: {
                    "Content-Type": "application/json"
                },
                load: function(data) {
                    saveFailedCallback("Removido.");
                },
                error: function(error) {
                    //We'll 404 in the demo, but that's okay.  We don't have a 'postIt' service on the
                    //docs server.
                    saveFailedCallback("Erro a remover.");
                }
            }
            dojo.byId("response2").innerHTML = "A remover..."
            //Call the asynchronous xhrPost
            var deferred = dojo.rawXhrPost(xhrArgs);

        } else {
            saveFailedCallback("ID nao obtido. " + b );
        }

    }
    else {
        return false;
    }

}

function anulardevice(id)
{
    if( confirm("Quer realmente anular o equipamento ? < " + id + " >") ) {
        // delete it!
        var b = dojo.byId("devices-" + id + "-idequipment").value;
        if (b > 0 ) {
            var unactive = dojo.byId("devices-" + id + "-dataout").value;
            var tmpunactive = {
                "dataout": unactive
            };

            var xhrArgs = {
                url: "/client/equipment/remove/" + b,
                postData: dojo.toJson(tmpunactive),
                handleAs: "json",
                headers: {
                    "Content-Type": "application/json"
                },
                load: function(data) {
                    saveFailedCallback("Anulado.");
                },
                error: function(error) {
                    saveFailedCallback("Erro a Anular.");
                }
            }
            dojo.byId("response2").innerHTML = "A anular..."
            //Call the asynchronous xhrPost
            var deferred = dojo.rawXhrPost(xhrArgs);

        } else {
            saveFailedCallback("ID nao obtido. " + b);
        }

    }
    else {
        return false;
    }

}

function setFile()
{
    maxd = document.getElementById("configfile-maxdown");
    maxu = document.getElementById("configfile-maxup");
    filename = document.getElementById("configfile-filename");
    macaddr = document.getElementById("Docsismodem-macaddr");

    if ( macaddr.value != '' ) {
        // alert("OI d: " + maxd.value + " up " + maxu.value + " m: " + macaddr.value );
        var newFileContentString = {
            "up" : maxu.value,
            "down" : maxd.value,
            "filename" : filename.value
        };

        dojo.xhrPost({
            url: "/docsismodem/genfile/id/" + macaddr.value,
            handleAs: "text",
            postData: dojo.toJson(newFileContentString),
            error: saveFailedCallback,
            load: function(response, ioArgs)
            {
                saveFailedCallback("Completo " + response );

                location.href = "/docsismodem/ver/id/"+macaddr.value;
            }
        });
    } else {
        saveFailedCallback("Erro mac address vazio " + macaddr.value );
    }
}

function saveFailedCallback(response, ioArgs)
{
    dojo.require("dijit.Dialog");
    var myDialog = new dijit.Dialog({
    // The dialog's title
        title: "Resultado da operação",
    // The dialog's content
        content: response.toString(),
    // Hard-code the dialog width
        style: "width:200px;"
    });

    myDialog.show();
}

function isCM(idCode)
{
    var teq = dijit.byId(idCode);
    if (teq.get('value') <= 0 ) {
        return false;
    }

    var tmp = "/client/equipment/gettype/id/" + teq.get('value');
    // get some data, convert to JSON

    dojo.xhrGet({
        url: tmp,
        handleAs:"json",
        load: function(dados) {
            var obj = dados[0];
            if (obj.code != 'MODEM') {
                return false;
            }

            if (hasModel(idCode)) {
                // will not provide way of adding model type
                return false;
            }

            addElementsEquipment(idCode);
        }
    });
}

function hasModel(idCode)
{
    var idCode = idCode.replace("idtypeequipment", "macaddr");
    var mac = dojo.byId(idCode);
    var macaddr = mac.value;
    var tmp = "/client/equipment/getbymac/id/" + macaddr;
    dojo.xhrGet({
        url: tmp,
        handleAs:"json",
        load: function(dados) {
            var obj = dados[0];
            if (obj.idmodel <= 0 ) {
                return false;
            }
            return true;
        }
    });
}

function addElementsEquipment( idCode)
{
    teq = dojo.query('[for="' + idCode + '"]');
    teq.attr("id", teq.attr("for") + "_a");

    var videntifier = teq.attr("for").toString() + '-idmodel';
    videntifier = videntifier.replace("-idtypeequipment", "");

    var brandStore = new dojo.data.ItemFileReadStore({
        url: "/device/getbrands"
    });
    // initiate it empty to fill it later
    var modelStore = new dojo.data.ItemFileReadStore({
        clearOnClose: true,
        urlPreventCache: true
    });

    var tar = videntifier.split("-");
    var vname = tar[0] + "[" + tar[1] + "][" + tar[2] +"]";

    var sel2 = new dijit.form.Select({
        name: vname,
        id: videntifier,
        store: modelStore
    });

    dv = document.createElement("DIV");

    dojo.create("label",
    {
        "for": videntifier+"_bs",
        innerHTML : "Marca"
    }, dv
    );

    var sel1 = new dijit.form.Select({
        label: "Marca",
        id: videntifier + "_bs",
        store: brandStore
    });

    sel1.attr("id", videntifier + "_bs");
    sel1.placeAt(dv);
    sel1.startup();

    dojo.create("label",
    {
        "for": videntifier,
        innerHTML : "Modelo"
    }, dv );

    sel2.placeAt(dv);
    sel2.startup();

    dojo.place(dv, teq.attr("id").toString(), "after");

    dojo.connect(dijit.byId(videntifier + "_bs"),
        "onChange",
        function() {
            updateCMB(dijit.byId(videntifier + "_bs").get("value"),
                modelStore, videntifier);
        }
    );
}

function updateCMB(value, modelStore, videntifier)
{
    if (value <= 0 ) {
        return false;
    }

    modelStore.url = "/device/getmodels/id/" + value;
    modelStore.close();

    modelStore.fetch(
    {
        onComplete:
        function (items, request) {
            var gr = dijit.byId(videntifier.toString());
            gr.setStore(modelStore);
        }
    });
}

function remotequery()
{
    console.log("issuing query...");
    var mac     = dojo.byId("rq-id");
    var tx      = dojo.byId("rq-tx");
    var snr     = dojo.byId("rq-snr");
    var rx      = dojo.byId("rq-rx");
    var config  = dojo.byId("rq-imagefile");
    var version = dojo.byId("rq-version");
    var rqlog   = dojo.byId("rq-log");
    var dsfreq  = dojo.byId("rq-downstreamfreq");
    var uptime  = dojo.byId("rq-uptime");

    if ( mac.value != '' ) {
        dojo.xhrPost({
            url: "/docsismodem/getremotequery/id/" + mac.value,
            handleAs: "text",
            postData: "",
            error: saveFailedCallback,
            load: function(response, ioArgs)
            {
                var data    = dojo.fromJson(response);
                tx.value    = (data.tx/10);
                snr.value   = (data.snr/10);
                rx.value    = (data.rx/10);
                dojo.byId("rq-microreflections").value    = (data.microreflections);
                version.value = (data.version);
                config.value = data.imagefile;
                rqlog.value = data.log;
                dsfreq.value = data.downstreamfreq;
                uptime.value = data.uptime;
                dojo.byId("rq-upstreamfreq").value = data.upstreamfreq;
                dojo.byId("rq-hw_rev").value = data.detailInfo.HW_REV;
                dojo.byId("rq-vendor").value = data.detailInfo.VENDOR;
                dojo.byId("rq-model").value = data.detailInfo.MODEL;
                dojo.byId("rq-bootr").value = data.detailInfo.BOOTR;
                dojo.byId("rq-sw_rev").value = data.detailInfo.SW_REV;

                return false;
            }
        });
    } else {
        saveFailedCallback("Falta o Macaddr.");
    }

    return false;
}

function remotereset()
{
    console.log("Reseting cm");
    var mac     = dojo.byId("rq-id");

    if (mac.value == "")  {
        console.log("no mac present " + mac.value);
        return false;
    }

    dojo.xhrPost({
            url: "/docsismodem/cmreset/id/" + mac.value,
            handleAs: "text",
            postData: "",
            error: saveFailedCallback,
            load: function(response, ioArgs)
            {
                var data    = (response);
                saveFailedCallback("CM Reset done.\n" + data.toString());
                return false;
            }
        });
}

function lastlease()
{
    var mac     = dojo.byId("lastlease-id").value;
    var data    = dojo.byId("lastlease-date").value;

    if ( mac != '' ) {
        dojo.xhrPost({
            url: "/docsismodem/getlastlease/id/" + mac + "/date/" + encodeURIComponent(data),
            handleAs: "text",
            postData: "",
            error: saveFailedCallback,
            load: function(response, ioArgs)
            {
                var dt    = dojo.fromJson(response);
                var newStore = new dojo.data.ItemFileReadStore({data: dt});

                var grid = dijit.byId('gridNodeidlease');
                grid.setStore(newStore);
            }
        });
    } else {
        saveFailedCallback("Falta o Macaddr.");
    }
}

function txrxview()
{
    var mac     = dojo.byId("txrx-id").value;
    var data    = dojo.byId("txrx-date").value;

    if ( mac != '' && data != '' ) {
        dojo.xhrPost({
            url: "/docsismodem/gettxrx/id/" + mac + "/date/" + encodeURIComponent(data),
            handleAs: "text",
            postData: "",
            error: saveFailedCallback,
            load: function(response, ioArgs)
            {
                var dt    = dojo.fromJson(response);
                var newStore = new dojo.data.ItemFileReadStore({data: dt});

                var grid = dijit.byId('gridRXTX');
                grid.setStore(newStore);
            }
        });
    } else {
        saveFailedCallback("Erro mac address " + mac + " ou Data em falta " + data);
    }
}

// append row to the HTML table
function appendRow(tablename) {
    var tbl = document.getElementById(tablename), // table reference
        row = tbl.insertRow(0);      // append table row tbl.rows.length
        //i;
    // insert table cells to the new row
//    for (i = 0; i < tbl.rows[1].cells.length; i++) {
//        createCell(row.insertCell(i), i, 'row');
//    }

    return row;
}

// create DIV element and append to the table cell
function createCell(cell, text, style)
{
    var div = document.createElement('div'), // create DIV element
        txt = document.createTextNode(text); // create text node
    div.appendChild(txt);                    // append text node to the DIV
    div.appendChild(lblxxx);
    div.setAttribute('class', style);        // set DIV class attribute
    div.setAttribute('className', style);    // set DIV class attribute for IE (?!)
    cell.appendChild(div);                   // append DIV to the table cell
}

function equipmentNewRow()
{
    /*
    var size = dojo.byId("equipmentsTable").rows.length;
    tr = dojo.create("tr", {} ,
        dojo.byId("equipmentsTable").tBodies[0]
    );
        /*((dojo.byId("equipmentsTable").rows.length)-1)
    */

   row = appendRow("equipmentsTable");
//    alert("B SIZE ");
//    dojo.create("td", {colspan: 6, innerHTML: "god :D"}, tr);
//    alert("C SIze");
}

var storePattern = 'yyyy-MM-dd hh:mm:ss';
var displayPattern = 'dd/MM/yyyy';

function formatDate(datum){
    if (datum == '0000-00-00 00:00:00') {
        return "00/00/0000";
    }
    /*Format the value in store, so as to be displayed.*/
    var d = dojo.date.locale.parse(datum, {
        selector: 'date',
        datePattern: storePattern
    });

    return dojo.date.locale.format(d, {
        selector: 'date',
        datePattern: displayPattern
    });
}

function getDateValue(){
    /*Override the default getValue function for dojox.grid.cells.DateTextBox*/
    return dojo.date.locale.format(this.widget.get('value'), {
        selector: 'date',
        datePattern: storePattern
    });
}

function validarTX(value, rowIdx, cell) {
    var tmp = value;

    if (value < 32) {
        tmp = "<span style='color: red;'>" + value + "</span>";
    }

    if (value > 50 ) {
        tmp = "<span style='color: orange;'>" + value + "</span>";
    }

    if (value >= 53 ) {
        tmp = "<span style='color: red;'>" + value + "</span>";
    }

    return tmp;
}

function validarRX(value, rowIdx, cell) {
    var tmp = value;

    if (value < -13 ) {
        tmp = "<span style='color: orange;'>" + value + "</span>";
    }

    if (value <= -15 ) {
        tmp = "<span style='color: red;'>" + value + "</span>";
    }

    if (value > 13 ) {
        tmp = "<span style='color: orange;'>" + value + "</span>";
    }

    if (value >= 15) {
        tmp = "<span style='color: red;'>" + value + "</span>";
    }

    return tmp;
}

function validarSNR(value, rowIdx, cell) {
    var tmp = value;

    if (value <= 34) {
        tmp = "<span style='color: orange;'>" + value + "</span>";
    }

    if (value < 32 ) {
        tmp = "<span style='color: red;'>" + value + "</span>";
    }

    return tmp;
}

function selectFile()
{
    var file = dijit.byId("servico-listFiles").get('value');
    dojo.byId("servico-config_file").value = file.toString();
    return true;
}