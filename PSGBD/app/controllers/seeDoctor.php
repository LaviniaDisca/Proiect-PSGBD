<?php


class SeeDoctor extends Controller
{
    public function index()
    {
        $data = array();
        $this->view('seeDoctor/index', $data);
    }
    public function Cautare()
    {
        $data=array();
        $verificare= array();
        $data['id']=$_POST['Id'];
        $user_model = $this->loadModel('DoctorModel');
        $verificare=$user_model->seeDoctor($data['id']);
        if($verificare !=null) {
            $data['nume'] = $user_model->seeDoctor($data['id'])[0];
            $data['sectie'] = $user_model->seeDoctor($data['id'])[1];
            $data['inceput'] = $user_model->seeDoctor($data['id'])[2];
            $data['sfarsit'] = $user_model->seeDoctor($data['id'])[3];
        }
        else
        {
            $data['nume'] = null;
            $data['sectie'] = null;
            $data['inceput'] = null;
            $data['sfarsit'] = null;

        }
        $this->view('seeDoctor/cautare', $data);
    }
}