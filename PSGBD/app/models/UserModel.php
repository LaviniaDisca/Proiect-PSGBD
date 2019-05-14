<?php

class UserModel extends Model
{

    public function exists($username, $password)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "begin getLoginInfo(:cursor, :username, :password); end;");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_bind_by_name($statement, ":username", $username, -1, SQLT_CHR);
        oci_bind_by_name($statement, ":password", $password, -1, SQLT_CHR);
        oci_execute($statement);
        oci_execute($c1);  // Execute the REF CURSOR like a normal statement id
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['ID_MEDIC'], $row['USERNAME'], $row['USER_PASS']);
        }
        return $result;
    }
}