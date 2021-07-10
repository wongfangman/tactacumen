<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlloadcart = "SELECT * FROM tbl_carts INNER JOIN tbl_products ON tbl_carts.prid = tbl_products.prid WHERE tbl_carts.user_email = '$email'";;

$result = $conn->query($sqlloadcart);

if ($result->num_rows > 0) {
    $products['cart'] = array();
    while ($row = $result->fetch_assoc()) {
        $prlist['prid'] = $row['prid'];
        $prlist['prname'] = $row['prname'];
        $prlist['prtype'] = $row['prtype'];
        $prlist['prprice'] = $row['prprice'];
        $prlist['cartqty'] = $row['cartqty'];
        $prlist['prqty'] = $row['prqty'];
        array_push($products['cart'], $prlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>