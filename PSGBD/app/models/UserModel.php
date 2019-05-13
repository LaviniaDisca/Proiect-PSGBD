<?php

class UserModel extends Model
{

    public function exists($username, $password)
    {
        $result = array();
        $c1 = oci_new_cursor($this->database);
        $statement = oci_parse($this->database, "SELECT * FROM login_info where username='" . $username . "' and user_pass ='" . $password . "'");
        oci_bind_by_name($statement, ":cursor", $c1, -1, OCI_B_CURSOR);
        oci_execute($statement);
        oci_execute($c1);  // Execute the REF CURSOR like a normal statement id
        while (($row = oci_fetch_array($c1, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
            array_push($result, $row['username'], $row['user_pass']);
        }
        return $result;
    }
}