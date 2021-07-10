<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$status = $_POST['status'];

$sqlloadstatus = "SELECT * FROM tbl_order
INNER JOIN tbl_products ON tbl_order.prid = tbl_products.prid 
INNER JOIN tbl_purchased ON tbl_order.orderid = tbl_purchased.orderid
WHERE tbl_order.user_email = '$email' AND tbl_purchased.status = '$status'";

$result = $conn->query($sqlloadstatus);

if ($result->num_rows > 0 ) {
    $response['order'] = array();
    while ($row = $result->fetch_assoc()) {
        $orderlist[prid] = $row['prid'];
        $orderlist[orderid] = $row['orderid'];
        $orderlist[prname] = $row['prname'];
        $orderlist[orderqty] = $row['orderqty'];
        $orderlist[prprice] = $row['prprice'];
        array_push($response['order'], $orderlist);
    }
    echo json_encode($response);
} 
else {
    echo "nodata";
}

?>