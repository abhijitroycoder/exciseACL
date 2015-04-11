<?php

class Default_Model_LibraryAcl {

    public function init() {

//      $db = Zend_Db_Table::getDefaultAdapter();

//        $dbConn = new Default_Model_PrepareAcl();
//        $roleslist = $dbConn->getRoles();
//
//        foreach ($roleslist as $role) {
//            if (!$role[inherited_role]) {
//                $this->addRole(new Zend_Acl_Role($role['rolename']));
//            } else {
//                $this->addRole(new Zend_Acl_Role($role['rolename']), $role['inherited_role']);
//            }
//        }
//
//        $modulesList = $dbConn->getModules();
//
//        foreach ($modulesList as $module) {
//
//            $this->add(new Zend_Acl_Resource($module['module_name']));
//        }
//
//        $moduleControllerList = $dbConn->getModulesControllers();
//
//        foreach ($moduleControllerList as $moduleController) {
//
//            $this->add(new Zend_Acl_Resource($moduleController['module_name'] . ":" . $moduleController['controller_name']), $moduleController['module_name']);
//        }
//
//        $roleMatrixList = $dbConn->getRoleMatrix();
//
//        foreach ($roleMatrixList as $roleMatrix) {
//
//            if($roleMatrix['permission']==1) {
//                $this->allow($roleMatrix['rolename'],$roleMatrix['module_name'].":".$roleMatrix['controller_name'],$roleMatrix['action_name']);
//            } else {
//                $this->deny($roleMatrix['rolename'],$roleMatrix['module_name'].":".$roleMatrix['controller_name'],$roleMatrix['action_name']);
//            }
//        }
    }
    
    public function createAcl(){
        
           $dbConn = new Default_Model_PrepareAcl();
        $roleslist = $dbConn->getRoles();

        foreach ($roleslist as $role) {
            if (!$role[inherited_role]) {
                $this->addRole(new Zend_Acl_Role($role['rolename']));
            } else {
                $this->addRole(new Zend_Acl_Role($role['rolename']), $role['inherited_role']);
            }
        }

        $modulesList = $dbConn->getModules();

        foreach ($modulesList as $module) {

            $this->add(new Zend_Acl_Resource($module['module_name']));
        }

        $moduleControllerList = $dbConn->getModulesControllers();

        foreach ($moduleControllerList as $moduleController) {

            $this->add(new Zend_Acl_Resource($moduleController['module_name'] . ":" . $moduleController['controller_name']), $moduleController['module_name']);
        }

        $roleMatrixList = $dbConn->getRoleMatrix();

        foreach ($roleMatrixList as $roleMatrix) {

            if($roleMatrix['permission']==1) {
                $this->allow($roleMatrix['rolename'],$roleMatrix['module_name'].":".$roleMatrix['controller_name'],$roleMatrix['action_name']);
            } else {
                $this->deny($roleMatrix['rolename'],$roleMatrix['module_name'].":".$roleMatrix['controller_name'],$roleMatrix['action_name']);
            }
        }
         return $this;
    }

}
