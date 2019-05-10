<?php

class Model
{

    public $database = null;

    function _construct()
    {
        $this->database = oci_connect(DB_USER, DB_PASS, DB_NAME);
    }
}

/*
$query = "SELECT * from sectii";
$res = oci_parse($database, $query);
oci_execute($res);
while ($row = oci_fetch_array($res, OCI_ASSOC + OCI_RETURN_NULLS)) {
    echo $row['NUME_SECTIE'] . "<br>";
}*/