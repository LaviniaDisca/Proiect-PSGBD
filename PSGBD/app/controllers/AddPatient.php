<?php

class AddPatient extends Controller
{

    public function index()
    {
        $data = '';
        $this->view('AddPatient/index', $data);
    }

    public function AddNewPatient()
    {
        $nume = $_POST['last_name'];
        $prenume = $_POST['first_name'];
        $user_model = $this->loadModel('PatientModel');
        $patient_id = $user_model->getNextPatientId()[0];
        $file_id = $user_model->getNextPatientFileId()[0];
        $birth_date = $_POST['birth_date'];
        $disease = $_POST['disease'];
        $user_model->addPatient($patient_id, $nume, $prenume, $birth_date, $disease, $file_id);
        $this->view('AddPatient/succes');
    }
}
