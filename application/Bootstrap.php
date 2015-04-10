<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
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

        $view->navigation($container);
    }
    
    
     protected function _initAutoload() {
        $modelLoader = new Zend_Application_Module_Autoloader(array(
                        'namespace' => 'Default',
                        'basePath' => APPLICATION_PATH.'/modules/default'));		
	     
        return $modelLoader;
    }


}

