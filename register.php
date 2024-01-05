<?php
include 'config.php';
$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];

$select = "SELECT * FROM user WHERE username = '" . $username . "' AND email = '" . $email . "' AND password = '" . $password . "'";
$result = mysqli_query($con, $select);
$count = mysqli_num_rows($result);
if ($count == 1) {
    echo json_decode("Error");
} else {
    $query = "INSERT INTO user VALUES(NULL,'" . $username . "','" . $email . "','" . $password . "')";
    $res = mysqli_query($con, $query);
    if ($res) {
        echo json_encode("success");
    } else {
        echo json_decode("error");
    }
}
mysqli_close($con);
