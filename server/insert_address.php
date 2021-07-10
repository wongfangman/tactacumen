<?php
include_once("dbconnect.php");
    $user_email = $_POST['email'];
    $fullname = $_POST['fullname'];
    $phoneno = $_POST['phoneno'];
    $detailedaddress = $_POST['detailedaddress'];
    $postalcode = $_POST['postalcode'];
    $city = $_POST['city'];
    $state = $_POST['state'];

$sqladdress = "SELECT * FROM tbl_addressbook WHERE user_email = '$user_email' AND fullname = '$fullname' AND phoneno = '$phoneno' AND detailedaddress = '$detailedaddress' AND postalcode = '$postalcode' AND city = '$city' AND state = '$state' "; 
$resultcheck = $conn->query($sqladdress);
    if ($resultcheck->num_rows != 0) {
          echo "Exist";
        }
else{
$sqlinsertaddress = "INSERT INTO tbl_addressbook (user_email, fullname, phoneno, detailedaddress, postalcode, city, state) VALUES ('$user_email', '$fullname', '$phoneno', '$detailedaddress', '$postalcode', '$city', '$state')";
            if ($conn->query($sqlinsertaddress) === TRUE) {
                echo "Success";
            } else {
                echo "Failed";
                
            }
    
}
?>