<?php

class Controller
{
    public function loadModel($model)
    {
        require_once 'app/models/'.$model.'.php';
        return new $model();
    }
    public function view($view,$data=[])
    {
        require_once 'app/views/'.$view.'.php';
    }

    public function getUsername()
    {
        session_start();
        if (!isset($_SESSION["userID"])) {
            header('Location: ' . URL . 'Login');
        }
        $user_model = $this->loadModel('UserModel');
        $result = $user_model->getUsername($_SESSION["userID"]);
        $num=$user_model->getNum();
        $username = $result[0].' '.$result[1].'!';
        return $username;
    }
}
