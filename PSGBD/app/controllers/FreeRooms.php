<?php

class FreeRooms extends Controller
{

    public function index()
    {
        session_start();
        if (!isset($_SESSION["userID"])) {
            header('Location: ' . URL . 'Home');
        }
        $user_model = $this->loadModel('UserModel');
        $ordered=$user_model->getFreeRooms();
        $data['specs']= array();
        $data['room']= array();
        $i=1;
        foreach ($ordered as $item) {
            if ($i % 2 == 1)
                array_push($data['specs'], $item);
            else
                array_push($data['room'], $item);
            $i=$i+1;
        }

        $this->view('FreeRooms/index',$data);

    }
}

