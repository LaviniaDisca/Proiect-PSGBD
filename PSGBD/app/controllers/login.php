<?php

class Login extends Controller
{
    public function index()
    {
        session_start();
        if(isset($_SESSION['userID'])){
            header('Location: ' . URL . 'Home');
        }
        if (isset($_SESSION['username_err'])) {
            $data['name'] = $_SESSION['username_err'];
        } else {
            $data['name'] = '';
        }
        unset($_SESSION['username_err']);
        if (isset($_SESSION['[password_err'])) {
            $data['pass'] = $_SESSION['[password_err'];
        } else {
            $data['pass'] = '';
        }
        unset($_SESSION['[password_err']);
        $this->view('Login/index', $data);
    }

    public function signIn()
    {
        if (isset($_POST['username']) && isset($_POST['password'])) {

            $username = $_POST['username'];
            $password = $_POST['password'];

            $user_model = $this->loadModel('UserModel');
            $result = $user_model->getInfo($username);
            if (!empty($result)) {
                $verify = password_verify($password, $result['password']);
                if ($verify == true) {
                    session_start();
                    unset($_SESSION['username_err']);
                    unset($_SESSION['[password_err']);
                    $_SESSION['userID'] = $result['id'];
                    if (isset($_SESSION['userID'])) {
                        header('Location: ' . URL . 'Home');
                    } else {
                        header('Location: ' . URL . 'Login');
                    }
                } else {
                    //handle wrong password
                    session_start();
                    $_SESSION['[password_err'] = 'Wrong password!';
                    header('Location: ' . URL . 'Login');
                }
            } else {
                //handle no user found
                session_start();
                $_SESSION['username_err'] = 'Username was not found!';
                header('Location: ' . URL . 'Login');
            }
        }
    }

    public function logOut()
    {
        session_start();
        unset($_SESSION['userID']);
        header('Location: ' . URL . 'Login');
    }
}
