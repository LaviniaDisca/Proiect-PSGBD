<?php


class Fire extends Controller
{
    public function index()
    {
        $this->view('fire/index');
    }

    public function delete()
    {
        $id=$_POST['Id'];
        $user_model = $this->loadModel('DoctorModel');
        $user_model->deleteMed($id);
        $this->view('fire/succes');
    }
}