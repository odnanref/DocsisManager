<?php

class omapi_Connection {

    private $key;
    private $port;
    private $path;
    public $server;

    function __construct($server = NULL) {
        if ($server) {
            $this->server = $server;
            $this->connect();
        }
    }

    function connect() {
        include 'lib/om-constants.php';
        $this->key = $omapi_key;
        $this->port = $omapi_port;
        $this->path = $omshellPath;
        $dspec = array(0 => array("pipe", "r"), 1 => array("pipe", "w"), 2 => array("pipe", "w"),);
        $success = array();
        $success[0] = false;
        $success[1] = "";
        $this->process = proc_open($this->path, $dspec, $this->pipes);
        if (is_resource($this->process)) {
            $this->readit();
            $this->writeit("port {$this->port}");
            $this->writeit("key omapi_key \"{$this->key}\"");
            $this->writeit("server {$this->server}");
            $this->writeit("connect");
        }
    }

    function add($mac, $group) {
        $this->init_host($mac);
        $output = $this->new_host($group);
        return $this->check_error($output);
    }

    function delete($mac) {
        $this->init_host($mac);
        $this->open_host();
        $output = $this->remove_host();
        return $this->check_error($output);
    }

    function query($mac) {
        $this->init_host($mac);
        $output = $this->open_host();
        return $this->check_error($output);
    }

    function init_host($mac) {
        if (is_resource($this->process)) {
            if ($this->init)
                $this->close(); $this->writeit("new host");
            $reply = $this->writeit("set hardware-address=$mac");
            if (!$this->check_error($reply))
                $this->init = 1;
        }
    }

    function new_host($group) {
        if (is_resource($this->process)) {
            $this->writeit("set known=1");
            $this->writeit("set hardware-type=1");
            $this->writeit("set group=\"$group\"");
            return $this->writeit("create");
        }
    }

    function open_host() {
        if (is_resource($this->process)) {
            return $this->writeit("open");
        }
    }

    function remove_host() {
        if (is_resource($this->process)) {
            $error = $this->writeit("remove");
            if (!$this->check_error($error))
                $this->init = 0; return $error;
        }
    }

    function close() {
        if (is_resource($this->process)) {
            return $this->writeit("close");
        }
    }

    function check_error($array) {
        if (!is_array($array))
            return false;
        
        $glob = implode('', $array);
        
        if (preg_match("/can't open object:.*/", $glob, $result))
            return $result[0];
    }

    function readit() {
        $end = '> ';
        $length = 1024;
        stream_set_blocking($this->pipes[1], FALSE);
        while (!feof($this->pipes[1])) {
            $buffer = fgets($this->pipes[1], $length);
            if ($buffer && $buffer != $end)
                $log[] = $buffer; if (substr_count($buffer, $end) > 0) {
                $pipes[1] = "";
                break;
            }
        } $this->logs[] = $log;
        return $log;
    }

    function writeit($str) {
        $this->logs[] = $str;
        fwrite($this->pipes[0], "$str\n");
        return $this->readit();
    }

    function __destruct() {
        fclose($this->pipes[0]);
        fclose($this->pipes[1]);
        return proc_close($this->process);
    }

}

?>
