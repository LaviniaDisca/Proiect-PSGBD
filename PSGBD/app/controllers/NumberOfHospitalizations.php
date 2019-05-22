<?php

class NumberOfHospitalizations extends Controller
{

    public function index()
    {
        session_start();
        if (!isset($_SESSION["userID"])) {
            header('Location: ' . URL . 'Home');
        }
        $user_model = $this->loadModel('PatientModel');
        if (isset($_POST['patientID'])) {
            $patientID = $_POST['patientID'];
            $num = $user_model->getNbHospitalizations($patientID);
            $verificare=$num;
                if($verificare==null)
                    $data['num']=0;

            else $data['num'] = $num[0];

        } else {
            $data['num'] = '';
        }
        $this->view('NumberOfHospitalizations/index', $data);
    }
}
