<?php

class stock extends Controller
{
    public function index()
    {
        session_start();
        if (!isset($_SESSION["userID"])) {
            header('Location: ' . URL . 'Home');
        }
        $user_model = $this->loadModel('MedsModel');
        $result = $user_model->showStock();
        $data['names']= array();
        $data['stock']= array();
        $i=1;
        foreach ($result as $item) {
            if ($i % 2 == 1)
                array_push($data['names'], $item);
            else
                array_push($data['stock'], $item);
            $i=$i+1;
        }
        $this->view('checkStock/index', $data);;
    }
}
