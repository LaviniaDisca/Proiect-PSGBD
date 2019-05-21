<?php


class Wards extends Controller
{
    public function index()
    {
        $this->view('wards/index');
    }

    public function Cautare()
    {
        $data=array();
        $data['id']=$_POST['Id'];
        $user_model = $this->loadModel('UserModel');
        $data['name']=$user_model->getWard($data['id'])[0];
        $this->view('wards/cautare', $data);
    }

}