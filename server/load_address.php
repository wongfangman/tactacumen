<?php

include_once("dbconnect.php");
$user_email = $_POST['email'];

$sqlloadaddress = "SELECT * FROM tbl_addressbook WHERE user_email = '$user_email'";
$result = $conn->query($sqlloadaddress);

if ($result->num_rows > 0){
    $response["address"] = array();
    while ($row = $result -> fetch_assoc()){
        $addresslist = array();
        $addresslist[user_email] = $row['user_email'];
        $addresslist[fullname] = $row['fullname'];
        $addresslist[phoneno] = $row['phoneno'];
        $addresslist[detailedaddress] = $row['detailedaddress'];
        $addresslist[postalcode] = $row['postalcode'];
        $addresslist[city] = $row['city'];
        $addresslist[state] = $row['state'];
        array_push($response["address"],$addresslist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>