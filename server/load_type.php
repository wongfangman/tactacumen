<?php

include_once("dbconnect.php");
$prtype= $_POST['prtype'];

if ($prtype == "all") {
    $sqlload = "SELECT * FROM tbl_products ORDER BY prid DESC";
} 
else {
    $sqlload = "SELECT * FROM tbl_products WHERE prtype LIKE '%$prtype%' ORDER BY prid DESC";
} 


$result = $conn->query($sqlload);

if ($result->num_rows > 0){
    $response["products"] = array();
    while ($row = $result -> fetch_assoc()){
        $prlist = array();
        $prlist[prid] = $row['prid'];
        $prlist[prname] = $row['prname'];
        $prlist[prtype] = $row['prtype'];
        $prlist[prprice] = $row['prprice'];
        $prlist[prqty] = $row['prqty'];
        $prlist[datecreated] = $row['datecreated'];
        array_push($response["products"],$prlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>