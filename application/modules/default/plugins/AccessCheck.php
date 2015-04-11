<?php
class Default_Plugin_AccessCheck extends Zend_Controller_Plugin_Abstract {
    
    private $_acl = null;
    
    public function __construct(Zend_Acl $acl) {
        $this->_acl = $acl;
    }
    
//     public function setAcl(Zend_Acl $acl) {
//        $this->_acl = $acl;
//    }

    public function preDispatch(Zend_Controller_Request_Abstract $request) {
    	$module = $request->getModuleName();
        $resource = $request->getControllerName();
        $action = $request->getActionName();
		  
        if(!$this->_acl->isAllowed(Zend_Registry::get('rolename'), $module.':'.$resource, $action)){
            $request->setModuleName('default')
		    ->setControllerName('authentication')
                    ->setActionName('login');
        }

    }
}
