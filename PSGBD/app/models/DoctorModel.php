<?php

class DoctorModel extends Model
{

    public function getNum()
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getDoctorNum(:cursor); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);  // Execute the REF CURSOR like a normal statement id
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['num']);
        }
        return $result;
    }

    public function getBySpec()
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getDoctorsbySpec(:cursor); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);  // Execute the REF CURSOR like a normal statement id
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['sect'], $row['med']);
        }
        return $result;
    }



    public function getShifts($medID)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getShifts(:cursor,:id); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_bind_by_name($statement, ":id", $medID, -1, SQLT_CHR);
        oci_execute($statement);
        oci_execute($c1);  // Execute the REF CURSOR like a normal statement id
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['Id_med'], $row['nume'], $row['prenume'], $row['inceput'], $row['sfarsit']);
        }
        return $result;
    }

    public function updateShift($medId, $in, $sf)
    {
        $statement = oci_parse($this->database, "begin updateShifts(:id, :inc, :sf); end;");
        oci_bind_by_name($statement, ":id", $medId, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":inc", $in, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":sf", $sf, -1, SQLT_CHR);
        oci_execute($statement);

    }

    public function getNextId()
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin geNextMedId(:cursor); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['new_id']);
        }
        return $result;
    }
    public function addMed($id, $nume, $prenume, $id_sectie, $inceput, $sfarsit)
    {

        $statement = oci_parse($this->database, "begin AddMed( :id, :nume, :prenume, :id_sectie, :inceput, :sfarsit); end;");
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":nume", $nume, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":prenume", $prenume, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":id_sectie", $id_sectie, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":inceput", $inceput, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":sfarsit", $sfarsit, -1, SQLT_CHR);
        oci_execute($statement);

    }

    public function Garda()
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin Garda(:cursor); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['sectie'], $row['nr']);
        }
        return $result;
    }

    public function deleteMed($id)
    {
        $statement = oci_parse($this->database, "begin deleteMed( :id); end;");
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_execute($statement);
    }
    public function getWardId($name)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getWardId(:cursor, :name); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_bind_by_name($statement, ":name", $name, -1, SQLT_CHR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['id']);
        }
        return $result;
    }
    public function seeDoctor($id)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin seeDoctor(:cursor, :id); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['nume'], $row['sectie'], $row['inceput'], $row['sfarsit']);
        }
        return $result;
    }

}