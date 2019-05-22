<?php


class Hospitalization extends Controller
{
    public function index()
    {
        $this->view('hospitalization/index');
    }

    public function Confirm()
    {
        $user_model = $this->loadModel('PatientModel');
        $id_fisa= $user_model->NextFileId()[0];
        $id_internare=$user_model->NextIntId()[0];
        $id_pac= $_POST['Id_pac'];
        $id_med=$_POST['Id'];
        $data_internare=$_POST['internare'];
        $boala=$_POST['boala'];
        $user_model->Hospitalize($id_fisa,$id_pac,$id_med,$boala, $id_internare,$data_internare);
        $this->view('hospitalization/succes');
    }
}