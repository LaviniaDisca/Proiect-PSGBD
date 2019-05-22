<?php

class AddMeds extends Controller
{
    public function index()
    {
        $this->view('AddMeds/index');
    }

    public function addMedicine()
    {
        $name = $_POST['denumire'];
        $stock = $_POST['stock'];
        $user_model = $this->loadModel('MedsModel');
        $id_med = $user_model->getNextMedId()[0];
        $user_model->addMed($id_med, $name, $stock);
        $this->view('AddMeds/succes');
    }

}
