<?php


class Fisa extends Controller
{
    public function index()
    {
        $this->view('fisa/index');
    }

    public function Cautare()
    {
        $data=array();
        $data['id']=$_POST['Id_pac'];
        $user_model = $this->loadModel('UserModel');
        $data['fisa']=$user_model->getFisa($data['id'])[0];
        $data['pacient']=$user_model->getFisa($data['id'])[1];
        $data['doctor']=$user_model->getFisa($data['id'])[2];
        $data['boala']=$user_model->getFisa($data['id'])[3];
        $this->view('fisa/cautare', $data);
    }

}