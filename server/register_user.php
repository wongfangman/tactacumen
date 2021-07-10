<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/hubbuddi/public_html/271221/tactacumen/php/PHPMailer/Exception.php';
require '/home8/hubbuddi/public_html/271221/tactacumen/php/PHPMailer/PHPMailer.php';
require '/home8/hubbuddi/public_html/271221/tactacumen/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");
$user_email = $_POST['email'];
$password = $_POST['password'];
$passhal1 = sha1($password);
$otp = rand(10000,99999);
$fullname = "";
$phoneno = "";
$gender = "";
$birthday = "";

$sqlregister = "INSERT INTO tbl_user(user_email,password,otp,fullname,phoneno,gender,birthday) VALUES('$user_email','$passhal1','$otp','$fullname','$phoneno','$gender','$birthday')";
if($conn->query($sqlregister) === TRUE){
    echo "success";
    sendEmail($otp,$user_email);
}else{
    echo "failed";
}

function sendEmail($otp,$user_email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0; 
    $mail->isSMTP(); 
    $mail->Host= 'mail.hubbuddies.com'; 
    $mail->SMTPAuth= true; 
    $mail->Username= 'tactacumen@hubbuddies.com'; 
    $mail->Password= 'tact.1517';
    $mail->SMTPSecure= 'tls';         
    $mail->Port= 587;
    
    $mail->setFrom("tactacumen@hubbuddies.com","Tact Acumen");
    $mail->addAddress($user_email);
    
    $mail->isHTML(true);
    $mail->Subject = "Please verify your email";
    $mail->Body  = "Use the following link to verify your account :"."\n https://hubbuddies.com/271221/tactacumen/php/verify_user.php?email=".$user_email."&key=".$otp;

    $mail->send();
}
?>