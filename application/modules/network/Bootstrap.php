<?php

/**
 * Bootstrap for users module
 *
 * @author andref
 * @version $Id$
 */
class Network_Bootstrap extends Zend_Application_Module_Bootstrap
{
    protected function _initResourceLoader()
    {
        $this->_resourceLoader->addResourceType('service', 'services', 'Users_Service');
        $this->_resourceLoader->addResourceType('serviceplugin', 'services/plugins', 'Users_Service_Plugin');
    }

}
