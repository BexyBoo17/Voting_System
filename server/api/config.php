<?php
$servername = "wheatley.cs.up.ac.za";
$user_id = "u17016534";
$password = "YBXYENJD2CURJU6273444J54VDPUFXUV";
$database_name = "u17016534_VotingSystem";


$conn = mysqli_connect($servername, $user_id, $password, $database_name);

if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  exit();
}

header('Content-Type: application/json');


 
?>