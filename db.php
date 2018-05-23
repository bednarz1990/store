<?php

$servername = "localhost";
$username = "root";
$password = "";
$db = "ecom";

// laczenie z baza
$con = mysqli_connect($servername, $username, $password,$db);

// sprawdzeniene polaczenia
if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}


?>