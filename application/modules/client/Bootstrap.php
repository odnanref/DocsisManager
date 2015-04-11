<?php

/**
 * Bootstrap for users module
 *
 * @author andref
 * @version $Id$
 */
class Client_Bootstrap extends Zend_Application_Module_Bootstrap
{
    private $_eventDispatcher = null;
    
    protected function _initResourceLoader()
    {
        $this->_resourceLoader->addResourceType('service', 'services', 'Client_Service');
        $this->_resourceLoader->addResourceType('serviceplugin', 'services/plugins', 'Client_Service_Plugin');
    }    

}

/**
 * 
 * protected function _initPlugins() 
	{	
		$loader = new Zend_Application_Module_Autoloader(
            array(
                'namespace' => 'Users',
                'basePath'  => APPLICATION_PATH . '/modules/users',
            ));
	}
 * 
 * To the main bootstrap add above code
 * 
 */