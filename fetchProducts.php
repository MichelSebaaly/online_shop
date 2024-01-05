<?php
include 'config.php';
$query = 'SELECT * FROM product';
$res = mysqli_query($con, $query);
if (mysqli_num_rows($res) > 0) {
    while ($row = mysqli_fetch_assoc($res)) {
        $product = array(
            "productId" => $row["productID"],
            "prodName" => $row["prodName"],
            "prodPrice" => $row["prodPrice"],
            "prodImage" => $row["prodImage"],
        );
        $products[] = $product;
    }
    echo json_encode($products);
} else {

    echo json_encode(array());
}

mysqli_close($con);
