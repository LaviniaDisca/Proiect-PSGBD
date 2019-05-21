<?php


class DischargePatient extends Controller
{
    public function index()
    {
        $this->view('DischargePatient/index');
    }

    public function Discharge()
    {
        $id=$_POST['Id'];
        $user_model = $this->loadModel('PatientModel');
        $user_model->deletePatient($id);
        $this->view('DischargePatient/succes');
    }
}