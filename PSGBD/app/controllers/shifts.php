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

    public function Actiune()
    {
        $data= array();
        $user_model = $this->loadModel('DoctorModel');
        if($_POST['Id'])
        {
            $id=$_POST['Id'];
            $data['id_med']=$user_model->getShifts($id)[0];
            $data['name']=$user_model->getShifts($id)[1]." ".$user_model->getShifts($id)[2];
            $data['shift']=$user_model->getShifts($id)[3]."-".$user_model->getShifts($id)[4];
            $i=1;
            $data['ward']=array();
            $data['num']=array();
            $ordered=$user_model->Garda();
            foreach ($ordered as $item) {
                if ($i % 2 == 1)
                    array_push($data['ward'], $item);
                else
                    array_push($data['num'], $item);
                $i=$i+1;
            }

        }

        if($_POST['actiune']=='Vizualizare') {
            $this->view('shifts/vizualizare', $data);
        }
        else if ($_POST['actiune']=='Editare')
        {
            $this->view('shifts/editare', $data);

        }
        else if($_POST['actiune']=='Modificare')
        {
            $inceput=$_POST['new_start'];
            $sfarsit=$_POST['new_end'];
            $user_model->updateShift($id, $inceput, $sfarsit);
            $this->view('shifts/succes', $data);
        }
    }





}