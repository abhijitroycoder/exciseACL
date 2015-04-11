<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    private $_acl = null;
    
    protected function _initAutoload() {
        $modelLoader = new Zend_Application_Module_Autoloader(array(
                        'namespace' => 'Default',
                        'basePath' => APPLICATION_PATH.'/modules/default'));		
	     
        if(Zend_Auth::getInstance()->hasIdentity()) {
			Zend_Registry::set('rolename', Zend_Auth::getInstance()->getStorage()->read()->rolename);
		} else {
			Zend_Registry::set('rolename', 'guest');
		}
		
//         $createACL = new Default_Model_LibraryAcl();
//         $this->_acl= $createACL->createAcl();
//        $this->_auth = Zend_Auth::getInstance();
//        
//        $fc = Zend_Controller_Front::getInstance();
//      
//        $fc->registerPlugin(new Default_Plugin_AccessCheck($this->_acl));
//        $ACLplugin = new Default_Plugin_AccessCheck();
//        $ACLplugin->setAcl($this->_acl);
//        $fc->registerPlugin($ACLplugin);
        
        
        return $modelLoader;
    }
    
    function _initNavigation() {
        $this->bootstrap('layout');
        $layout = $this->getResource('layout');
        $view = $layout->getView();

        $view->setHelperPath(APPLICATION_PATH . '/helpers', '');
//        ZendX_JQuery::enableView($view);

        $view->doctype('HTML4_STRICT');
        $view->headMeta()->appendHttpEquiv('Content-type', 'text/html;charset=utf-8')
                ->appendName('description', 'excise ACL');

        $view->headTitle()->setSeparator(' - ')
                ->headTitle('Excise ACL');

        //read navigation XML and initialize container
        $config = new Zend_Config_Xml(APPLICATION_PATH . '/configs/exciseAclNavigation.xml');
        $container = new Zend_Navigation($config);

        $view->navigation($container);//->setAcl($this->_acl)->setRole(Zend_Registry::get('rolename'));
    }
    
    
     


}

