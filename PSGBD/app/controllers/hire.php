<?php


class Hire extends Controller
{
    public function index()
    {
        $data= array();
        $user_model = $this->loadModel('UserModel');
        $this->view('hire/index', $data);
    }

    public function Adaugare()
    {
        $nume=$_POST['first-name'];
        $prenume=$_POST['last-name'];
        $user_model = $this->loadModel('UserModel');
        $id=$user_model->getNextId()[0];
        $sectie=$_POST['ward'];
        $id_sectie=$user_model->getWardId($sectie)[0];
        $inceput=$_POST['begin'];
        $sfarsit=$_POST['end'];
        $user_model->addMed($id, $nume, $prenume, $id_sectie, $inceput, $sfarsit);
        $this->view('hire/succes');

    }
}