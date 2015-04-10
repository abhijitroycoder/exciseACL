<?php

class Default_Model_PrepareAcl
{
    
    public function getRoleMatrix(){
        
        $db = Zend_Db_Table::getDefaultAdapter();
        
        $selectRoles = new Zend_Db_Select($db);
        $selectRoles->from('roles');
        
        $result = $db->fetchAll($selectRoles);
        
        return $result;
    }


}

