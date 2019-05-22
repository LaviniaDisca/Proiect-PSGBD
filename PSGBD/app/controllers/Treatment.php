<?php

class Treatment extends Controller
{
    public function index()
    {
        $this->view('PrescribeTreatment/index');
    }

    public function prescribe()
    {
        $id_patient = $_POST['patient'];
        $id_doctor = $_POST['doctor'];
        $start = $_POST['start'];
        $finish = $_POST['finish'];
        $med1 = $_POST['med1'];
        $user_model = $this->loadModel('MedsModel');
        $Med1 = $user_model->getMedID($med1)[0];
        if (isset($_POST['med2'])) {
            $med2 = $_POST['med2'];
            $Med2 = @$user_model->getMedID($med2)[0];
        } else {
            $Med2 = '-';
        }
        if (isset($_POST['med3'])) {
            $med3 = $_POST['med3'];
            $Med3 = @$user_model->getMedID($med3)[0];
        } else {
            $Med3 = '-';
        }
        if (isset($_POST['med4'])) {
            $med4 = $_POST['med4'];
            $Med4 = @$user_model->getMedID($med4)[0];
        } else {
            $Med4 = '-';
        }
        if (isset($_POST['med5'])) {
            $med5 = $_POST['med5'];
            $Med5 = @$user_model->getMedID($med5)[0];
        } else {
            $Med5 = '-';
        }
        if (isset($_POST['med6'])) {
            $med6 = $_POST['med6'];
            $Med6 = @$user_model->getMedID($med6)[0];
        } else {
            $Med6 = '-';
        }
        if (isset($_POST['med7'])) {
            $med7 = $_POST['med7'];
            $Med7 = @$user_model->getMedID($med7)[0];
        } else {
            $Med7 = '-';
        }
        if (isset($_POST['med8'])) {
            $med8 = $_POST['med8'];
            $Med8 = @$user_model->getMedID($med8)[0];
        } else {
            $Med8 = '-';
        }
        $user_model->addTreatment($id_patient, $id_doctor, $start, $finish, $Med1, $Med2, $Med3, $Med4, $Med5, $Med6, $Med7, $Med8);
        $this->view('PrescribeTreatment/succes');
    }
}
