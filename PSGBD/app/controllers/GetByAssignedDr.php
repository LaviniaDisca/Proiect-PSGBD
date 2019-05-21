<?php

class GetByAssignedDr extends Controller
{

    public function index()
    {
        $data = array();
        $data['id'] = '';
        $data['patients'] = '';
        $this->view('GetByAssignedDr/index', $data);

    }

    public function Display()
    {
        session_start();
        $data = array();
        $user_model = $this->loadModel('PatientModel');
        if (!isset($_SESSION["userID"])) {
            header('Location: ' . URL . 'Home');
        }
        if (isset($_POST['id'])) {

            $id = $_POST['id'];
            $data['id'] = $id;
            $result = $user_model->getByAssignedDr($id);
            $data['patients'] = array();
            foreach ($result as $item) {
                array_push($data['patients'], $item);
            }
        } else {
            $data['patients'] = '';
        }
        if ($_POST['actiune'] == 'Vizualizare') {

            $this->view('GetByAssignedDr/Vizualizare', $data);
        }

    }
}

