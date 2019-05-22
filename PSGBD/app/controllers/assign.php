<?php


class Assign extends Controller
{
    public function index()
    {
        $this->view('assignSalon/index');
    }

    public function Asignare()
    {
        $data=array();
        $data['id']=$_POST['Id_pac'];
        $user_model = $this->loadModel('PatientModel');
        $data['id_salon']=$user_model->getFirstFreeSalon()[0];
        $user_model->assignSalon($data['id'],$data['id_salon'])[0];
        $this->view('assignSalon/cautare', $data);

    }
}