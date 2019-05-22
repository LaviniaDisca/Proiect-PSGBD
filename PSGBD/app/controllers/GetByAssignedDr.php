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
        if (isset($_POST['Id'])) {

            $id = $_POST['Id'];
            $data['Id'] = $id;

            $result = $user_model->getByAssignedDr($id);
            $data['nume_med']=$result[2];
            $data['patients'] = array();
            $i=1;
            foreach ($result as $item) {
                if ($i % 2 == 0)
                    array_push($data['patients'], $item);
                $i=$i+1;
                if($i==4)
                    $i=1;
            }
        } else {
            $data['patients'] = '';
        }
        if ($_POST['actiune'] == 'Vizualizare') {

            $this->view('GetByAssignedDr/vizualizare', $data);
        }

    }
}

