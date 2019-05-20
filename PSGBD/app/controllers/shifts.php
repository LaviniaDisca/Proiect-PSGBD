<?php


class Shifts extends Controller
{
    public function index()
    {
        $data= array();
        $data['id_med']=null;
        $data['name']=null;
        $data['shift']=null;
        $data['vizualizare']=null;
        $data['editare']=null;
        $this->view('shifts/index', $data);

    }

    public function Vizualizare()
    {
        $data= array();
        if($_POST['Id'])
        {
            $id=$_POST['Id'];
            $user_model = $this->loadModel('UserModel');
            $data['id_med']=$user_model->getShifts($id)[0];
            $data['name']=$user_model->getShifts($id)[1]." ".$user_model->getShifts($id)[2];
            $data['shift']=$user_model->getShifts($id)[3]."-".$user_model->getShifts($id)[4];
        }
        $this->view('shifts/vizualizare', $data);
    }

    public function Editare()
    {
        $data= array();
        if($_POST['Id'])
        {
            $id=$_POST['Id'];
            $user_model = $this->loadModel('UserModel');
            $data['id_med']=$user_model->getShifts($id)[0];
            $data['name']=$user_model->getShifts($id)[1]." ".$user_model->getShifts($id)[2];
            $data['shift']=$user_model->getShifts($id)[3]."-".$user_model->getShifts($id)[4];
        }


        $this->view('shifts/editare', $data);
    }


}