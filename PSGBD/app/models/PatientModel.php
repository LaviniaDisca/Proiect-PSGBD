<?php

class PatientModel extends Model
{
    public function getNextPatientFileId()
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getNextPatientFileId(:cursor); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['new_id']);
        }
        return $result;
    }
    public function getNextPatientId()
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getNextPatientId(:cursor); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['new_id']);
        }
        return $result;
    }

    public function addPatient($id, $last_name, $first_name, $birth_date, $disease, $file)
    {
        $statement = oci_parse($this->database, "begin AddPatient(:id, :nume, :prenume, :birth_date, :disease, :file); end;");
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":nume", $last_name, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":prenume", $first_name, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":birth_date", $birth_date, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":disease", $disease, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":file", $file, -1, SQLT_CHR);
        oci_execute($statement);
    }


    public function deletePatient($id)
    {
        $statement = oci_parse($this->database, "begin dischargePatient(:id); end;");
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_execute($statement);
    }


    public function getByAssignedDr($id)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getByAssignedDr(:cursor,:id); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['name'], $row['pren'], $row['drName'], $row['drPren']);
        }
        return $result;
    }

    public function getNbHospitalizations($patientID)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getNbHospitalizations(:cursor,:id); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_bind_by_name($statement, ":id", $patientID, -1, SQLT_CHR);
        oci_execute($statement);
        oci_execute($c1);  // Execute the REF CURSOR like a normal statement id
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['numInternari']);
        }
        return $result;
    }
    public function getFisa($id)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin Fisa(:cursor, :id); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_bind_by_name($statement, ":id", $id, -1, SQLT_CHR);
        oci_execute($statement);
        oci_execute($c1);
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['fisa'], $row['pacient'], $row['medic'], $row['boala']);
        }
        return $result;
    }

}