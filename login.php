<?php
session_start();
include 'db_connection.php';

if (isset($_POST['login-submit'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    

    $sql = "SELECT * FROM users WHERE username='$username'";
    $result = mysqli_query($connection2, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        if (password_verify($password, $row['password'])) {
            // Password is correct; start a session and redirect to dashboard or index
            $_SESSION['username'] = $username;

            // Get the user's IP address
            $ipAddress = $_SERVER['REMOTE_ADDR'];

            // Insert a login history record into the user_management database
            $sql = "INSERT INTO login_history (username, login_time, ip_address) VALUES ('$username', NOW(), '$ipAddress')";
            if (mysqli_query($connection2, $sql)) {
                // Insertion successful
            } else {
                // Error handling
                echo "Error: " . $sql . "<br>" . mysqli_error($connection2);
            }

            mysqli_close($connection2); // Close the user management database connection

            header('Location: ../dashboard.php');
            exit;
        } else {
            echo "Invalid password. Please try again.";
        }
    } else {
        echo "Invalid username. Please try again.";
    }
}
?>