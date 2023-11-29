<?php
session_start();
if (!isset($_SESSION['username'])) {
    header('Location: login.html');
    exit;
}

include 'php/db_connection.php';

// Get the user's username
$username = $_SESSION['username'];

// Query to retrieve the user's role
$role_sql = "SELECT role FROM users WHERE username='$username'";
$role_result = mysqli_query($connection2, $role_sql);

if ($role_result && mysqli_num_rows($role_result) > 0) {
    $row = mysqli_fetch_assoc($role_result);
    $userRole = $row['role'];

    if ($userRole === 'citizen') {
        // Delete the user's account
        $delete_sql = "DELETE FROM users WHERE username='$username'";
        if (mysqli_query($connection2, $delete_sql)) {
            // Redirect to the login page after deletion
            header('Location: login.html');
            exit();
        } else {
            echo 'Error: ' . mysqli_error($connection2);
        }
    } else {
        echo 'You are not authorized to delete this account.';
    }
} else {
    echo 'Error retrieving user role.';
}

mysqli_close($connection2);
?>
