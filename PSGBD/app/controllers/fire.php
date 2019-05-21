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
        $user_model = $this->loadModel('UserModel');
        $user_model->deleteMed($id);
        $this->view('fire/succes');
    }
}