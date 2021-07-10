<?php
include_once("dbconnect.php");
    $user_email = $_POST['email'];
    $fullname = $_POST['fullname'];
    $phoneno = $_POST['phoneno'];
    $detailedaddress = $_POST['detailedaddress'];
    $postalcode = $_POST['postalcode'];
    $city = $_POST['city'];
    $state = $_POST['state'];
$sqldelete = "DELETE FROM tbl_addressbook  WHERE user_email = '$user_email' AND fullname = '$fullname' AND phoneno = '$phoneno' AND detailedaddress = '$detailedaddress' AND postalcode = '$postalcode' AND city = '$city' AND state = '$state'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Failed";
}
?>