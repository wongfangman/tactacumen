<?php
$servername = "localhost";
$username   = "hubbuddi_tactacumenadmin";
$password   = "uNOxJRyxyR3#";
$dbname     = "hubbuddi_tactacumendb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
?>