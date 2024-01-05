

<?php
header('Content-Type: application/json');
header('Content-Type: application/json; charset=utf-8');

include 'config.php';

// Assuming the request is a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $query = "SELECT * FROM user WHERE email = '" . $email . "' AND password = '" . $password . "'";
    $res = mysqli_query($con, $query);

    // Check if there is a matching user
    if (mysqli_num_rows($res) > 0) {
        $data = mysqli_fetch_assoc($res);
        // if (count($data) == 0) {
        // $response = array("status" => "wrongPass", "message" => "wrong email or password");
        // }
        // Assuming you want to return user data

        $response = array(
            "status" => "success",
            "user" => array(
                "email" => $data['email'],
                "password" => $data['password']
            )
        );
    } else {
        // No matching user found
        $response = array("status" => "NotFound", "message" => "Account Not Found");
    }


    // Return the response in JSON format
    echo json_encode($response);
} else {
    // Invalid request method
    http_response_code(400);
    echo json_encode(array("status" => "error", "message" => "Invalid request method"));
}

// Close the database connection
mysqli_close($con);
?>