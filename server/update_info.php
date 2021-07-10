<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $user_email = $_POST['email'];
    $fullname = $_POST['fullname'];
    $phoneno = $_POST['phoneno'];
    $gender = $_POST['gender'];
    $birthday = $_POST['birthday'];
    
    $sqlupdate = "UPDATE tbl_user SET fullname = '$fullname', phoneno ='$phoneno', gender = '$gender', birthday = '$birthday' WHERE user_email = '$user_email'";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'Success';
        }else{
        echo $user_email;
        echo $fullname;
        echo $phoneno;
        echo $gender;
        echo $birthday;
            
        echo 'Failed';
        }
?>