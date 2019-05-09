<?php

/*class Model {

    public $database = null;

    function _construct() {

    }
}*/

  $database = oci_connect("admin","ADMIN","localhost/XE");

  $query = "SELECT * from sectii";
  $res = oci_parse($database,$query);
  oci_execute($res);
while ($row = oci_fetch_array($res, OCI_ASSOC+OCI_RETURN_NULLS)){
    echo $row['NUME_SECTIE'] . "<br>";
}