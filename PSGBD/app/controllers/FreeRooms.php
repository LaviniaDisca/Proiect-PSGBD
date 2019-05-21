<?php

class FreeRooms extends Controller
{

    public function index()
    {
        $data = array();
        $data['sectie'] = '';
        $data['room'] = '';
        $this->view('FreeRooms/index', $data);

    }

    public function See()
    {
        session_start();
        $data = array();
        $user_model = $this->loadModel('UserModel');
        if (!isset($_SESSION["userID"])) {
            header('Location: ' . URL . 'Home');
        }
        if (isset($_POST['sectie'])) {

            $sectie = $_POST['sectie'];
            $data['sectie'] = $sectie;
            $ordered = $user_model->getFreeRooms($sectie);
            $data['room'] = array();
            foreach ($ordered as $item) {
                array_push($data['room'], $item);
            }
        } else {
            $data['room'] = '';
        }
        if ($_POST['actiune'] == 'Vizualizare') {

            $this->view('FreeRooms/Vizualizare', $data);
        }

    }
}

