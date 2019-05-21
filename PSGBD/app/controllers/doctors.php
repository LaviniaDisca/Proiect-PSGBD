<?php



class Doctors extends Controller
{

    public function index()
    {
        session_start();
        if (!isset($_SESSION["userID"])) {
            header('Location: ' . URL . 'Home');
        }
        $user_model = $this->loadModel('DoctorModel');
        $num=$user_model->getNum();
        $data['num']=$num[0];
        $ordered=$user_model->getBySpec();
        $data['specs']= array();
        $data['meds']= array();
        $i=1;
        foreach ($ordered as $item) {
            if ($i % 2 == 1)
                array_push($data['specs'], $item);
            else
                array_push($data['meds'], $item);
            $i=$i+1;
        }

        $this->view('doctors/index', $data);
    }
}
