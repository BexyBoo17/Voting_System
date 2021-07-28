<?php
$servername = "localhost";
$user_id = "username";
$password = "password";
$dbname = "myDB";


$conn = new mysqli($servername, $user_id, $password, $dbname);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO Marks3 (Q1, Q2, Q3, Q4, Q5)
VALUES (' ', ' ', ' ', ' ', ' ')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>