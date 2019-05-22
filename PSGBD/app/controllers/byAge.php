<?php


class byAge extends Controller
{
    public function index()
    {
        $data=array();
        $user_model = $this->loadModel('PatientModel');
        $data['infants']=$user_model->InfantsNumber()[0];
        $data['kids']=$user_model->KidsNumber()[0];
        $data['adults']=$user_model->AdultsNumber()[0];
        $data['elders']=$user_model->EldersNumber()[0];
        $this->view('byAge/index',$data);
    }
}