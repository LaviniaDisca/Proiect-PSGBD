<?php

class MedsModel extends Model
{
    public function getNextMedId()
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getNextMedsId(:cursor); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['new_id']);
        }
        return $result;
    }

    public function addMed($id, $nume, $stock)
    {
        $statement = oci_parse($this->database, "begin AddMeds( :id, :nume, :stock); end;");
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":nume", $nume, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":stock", $stock, -1, SQLT_CHR);
        oci_execute($statement);
    }

    public function showStock()
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin checkStock(:cursor); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['DENUMIRE'], $row['STOC']);
        }
        return $result;
    }

    public function getMedID($id)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getMedId(:cursor, :id); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['ID_MEDICAMENT']);
        }
        return $result;
    }

    public function addTreatment($id_patient, $id_doctor, $data_start, $data_finish, $med1, $med2, $med3, $med4, $med5, $med6, $med7, $med8)
    {
        $statement = oci_parse($this->database, "begin addTreatment(:id_patient, :id_doctor, :data_start, :data_finish, :med1, :med2, :med3, :med4, :med5, :med6, :med7, :med8); end;");
        oci_bind_by_name($statement, ":id_patient", $id_patient, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":id_doctor", $id_doctor, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":data_start", $data_start, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":data_finish", $data_finish, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":med1", $med1, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":med2", $med2, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":med3", $med3, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":med4", $med4, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":med5", $med5, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":med6", $med6, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":med7", $med7, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":med8", $med8, -1, SQLT_CHR);
        oci_execute($statement);
    }

    public function updateStock($id, $new_value)
    {
        $statement = oci_parse($this->database, "begin updateStock(:id, :new_value); end;");
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":new_value", $new_value, -1, SQLT_CHR);
        oci_execute($statement);
    }
}