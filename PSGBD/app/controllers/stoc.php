<?php


class Stoc extends Controller
{
    public function index()
    {

        $data=array();

        $user_model = $this->loadModel('UserModel');
        $ordered = $user_model->Stoc();
        $i=1;
        $data['med']=array();
        $data['cant']=array();
        foreach ($ordered as $item) {
            if ($i % 2 == 1)
                array_push($data['med'], $item);
            else
                array_push($data['cant'], $item);
            $i = $i + 1;
        }
        $this->view('stoc/index',$data);
    }
}