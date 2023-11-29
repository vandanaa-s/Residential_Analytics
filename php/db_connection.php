<?php

$host = "localhost";
$user = "root";
$password = "welcome1-2";
$database = "bangalore_residential_analytics";

$connection = mysqli_connect($host, $user, $password, $database);

if (!$connection) {
  die("Connection failed: " . mysqli_connect_error());
}


$host2 = "localhost";
$user2 = "root";
$password2 = "welcome1-2";
$database2 = "user_management"; 

$connection2 = mysqli_connect($host2, $user2, $password2, $database2);

if (!$connection2) {
    die("Connection to user management database failed: " . mysqli_connect_error());
}
?>