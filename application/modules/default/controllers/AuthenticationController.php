<?php

class Default_AuthenticationController extends Zend_Controller_Action {

    public function init() {
//        $jquery = $this->view->jQuery();
//        $jquery->enable();
//        $jquery->uiEnable();
    }

    public function indexAction() {
        // action body
    }

    public function loginAction() {
        $this->view->headTitle('Login page', 'PREPEND');

        if (Zend_Auth::getInstance()->hasIdentity()) {
            $this->_redirect('default/authentication/login');
        }

        $form = new Default_Form_LoginForm();
        $request = $this->getRequest();

        if ($request->isPost()) {
            if ($form->isValid($this->_request->getPost())) {
                $authAdapter = $this->getAuthAdapter();

                $username = $form->getValue('username');
                $password = $form->getValue('password');

                $authAdapter->setIdentity($username)
                        ->setCredential($password);

                $auth = Zend_Auth::getInstance();
                $result = $auth->authenticate($authAdapter);

                if ($result->isValid()) {
                    $identity = $authAdapter->getResultRowObject();

                    $authStorage = $auth->getStorage();
                    $authStorage->write($identity);

                    $this->_redirect('importPermit/apply/index');
                } else {
                    $this->view->errorMessage = "User name or password is wrong.";
                }
            }
        }

        $this->view->form = $form;
        // can use either one
        // directly access dbtable
//        $rolesTBL = new Default_Model_DbTable_Roles();
//        $this->view->roles = $rolesTBL->fetchAll();

        //access dbtable through model
        $roles = new Default_Model_PrepareAcl();
        $roleslist = $roles->getRoles();
        $this->view->roles = $roleslist;
    }

    public function logoutAction() {
        $this->view->headTitle('Logout page', 'PREPEND');
        Zend_Auth::getInstance()->clearIdentity();
        $this->_redirect('default/authentication/login');
    }

    private function getAuthAdapter() {
        $authAdapter = new Zend_Auth_Adapter_DbTable(Zend_Db_Table::getDefaultAdapter());
        $authAdapter->setTableName('users')
                ->setIdentityColumn('username')
                ->setCredentialColumn('password');

        return $authAdapter;
    }

}
