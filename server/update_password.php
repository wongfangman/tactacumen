<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $email = $_POST['email'];
    
    $currentpassword = $_POST['currentpassword'];
    $passhal = sha1($currentpassword);
    
    $newpassword = $_POST['newpassword'];
    $passhal1 = sha1($newpassword);
    
    $sqlcheck = "SELECT * FROM tbl_user WHERE user_email= '$email' AND password = '$passhal'";
    $result = $conn-> query ($sqlcheck);
    if($result ->num_rows>0){
     $sqlupdate = "UPDATE tbl_user SET password = '$passhal1' WHERE user_email= '$email'";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'Success';
        }
        else{
        echo 'Failed';
        }
    }
    else{
        echo 'Failed';
        }
?>