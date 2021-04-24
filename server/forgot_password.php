<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/hubbuddi/public_html/271221/tactacumen/php/PHPMailer/Exception.php';
require '/home8/hubbuddi/public_html/271221/tactacumen/php/PHPMailer/PHPMailer.php';
require '/home8/hubbuddi/public_html/271221/tactacumen/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$email = $_POST['email'];

$password= password_generate(6);
$passha = sha1($password);

$sql = "SELECT * FROM tbl_user WHERE user_email = '$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
$sqlupdate = "UPDATE tbl_user SET password = '$passha', otp = '0' WHERE user_email = '$email'";
if ($conn->query($sqlupdate) === TRUE){
 echo "success";
 sendEmail($email,$password);
}
}else{
echo 'failed';
}

function password_generate($chars) 
{
  $data = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcefghijklmnopqrstuvwxyz';
  return substr(str_shuffle($data), 0, $chars);
}


function sendEmail($email,$password){
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
    $mail->addAddress($email);
    
    $mail->isHTML(true);
    $mail->Subject = "Your temporary password is created.";
    $mail->Body  = "Your temporary password is <strong>$password</strong>,use the following password to Login";

    $mail->send();
}
?>