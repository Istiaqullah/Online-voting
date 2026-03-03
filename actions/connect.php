<?php

$con = mysqli_connect("localhost", "root", "", "dbmslab");

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

?>