<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$fbtype= $_POST['fbtype'];
$fbmessage = $_POST['fbmessage'];

$sqlinsert = "INSERT INTO tbl_feedbacks(user_email, feedback_type, feedback_message) VALUES ('$email','$fbtype', '$fbmessage')";
            if ($conn->query($sqlinsert) === TRUE) {
                echo "Success";
            } else {
                echo "Failed";
            }
    

?>