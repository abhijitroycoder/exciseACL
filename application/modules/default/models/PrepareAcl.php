<?php

class Default_Model_PrepareAcl {

    public function getRoles() {

        $db = Zend_Db_Table::getDefaultAdapter();

//        $selectRoles = new Zend_Db_Select($db);
//        $selectRoles->from('roles');
        
        $selectStatement = "select * from roles";

        $result = $db->fetchAll($selectStatement);

        return $result;
    }

    public function getRoleMatrix() {

        $db = Zend_Db_Table::getDefaultAdapter();

        $selectStatement = "select module_name,controller_name,action_name,rolename,permission
      from modules,controllers,actions,resources_privileges,roles_resources_privileges,roles
       where modules.idmodules=resources_privileges.idmodules and
              controllers.idcontrollers=resources_privileges.idcontrollers and
                actions.idactions=resources_privileges.idactions and
                  resources_privileges.idresources_privileges=roles_resources_privileges.idresources_privileges and
                    roles_resources_privileges.idroles=roles.idroles";

        $selectMatrixList = $db->fetchAll($selectStatement);

        return $selectMatrixList;
    }

    public function getModules() {

        $db = Zend_Db_Table::getDefaultAdapter();

        $selectStatement = "select distinct module_name 
                                from modules,resources_privileges 
                                  where modules.idmodules=resources_privileges.idmodules";

        $selectModuleList = $db->fetchAll($selectStatement);

        return $selectModuleList;
    }

    public function getModulesControllers() {

        $db = Zend_Db_Table::getDefaultAdapter();

        $selectStatement = "select distinct module_name,controller_name 
                              from modules,controllers,resources_privileges 
                                  where modules.idmodules=resources_privileges.idmodules and
                                          controllers.idcontrollers=resources_privileges.idcontrollers";

        $selectModuleControllerList = $db->fetchAll($selectStatement);

        return $selectModuleControllerList;
    }

}
