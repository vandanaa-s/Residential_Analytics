<?php
session_start();
if (!isset($_SESSION['username'])) {
    header('Location: login.html');
    exit;
}

include 'php/db_connection.php';

// Check the user's role
$username = $_SESSION['username'];

$sql = "SELECT role FROM users WHERE username='$username'";
$result = mysqli_query($connection2, $sql);

if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $userRole = $row['role'];

    // Check if the user is an admin
    if ($userRole !== 'admin') {
        header('Location: dashboard.php'); // Redirect non-admin users to the dashboard
        exit;
    }
}

// Query login history
$sql = "SELECT username, login_time, ip_address FROM login_history";
$result = mysqli_query($connection2, $sql);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body class="dashboard-body">
    <h1 style="color:white;text-align: center;">Login History</h1>

    <?php
    // Display the login history in a table
    if (mysqli_num_rows($result) > 0) {
        echo '<table class="login-history-table" style="border: 2px solid white; background-color: white; color: white; width: 100%; max-width: 800px; margin: 20px auto;">';
        echo '<tr class="login-history-header" style="background-color: #333; color: white;">';
        echo '<th style="font-weight: bold; padding: 8px; text-align: left;">Username</th>';
        echo '<th style="font-weight: bold; padding: 8px; text-align: left;">Login Time</th>';
        echo '<th style="font-weight: bold; padding: 8px; text-align: left;">IP Address</th>';
        echo '</tr>';
        while ($row = mysqli_fetch_assoc($result)) {
            echo '<tr class="login-history-row" style="background-color: #333;">';
            echo '<td style="padding: 8px; text-align: left;">' . $row['username'] . '</td>';
            echo '<td style="padding: 8px; text-align: left;">' . $row['login_time'] . '</td>';
            echo '<td style="padding: 8px; text-align: left;">' . $row['ip_address'] . '</td>';
            echo '</tr>';
        }
        echo '</table>';
    } else {
        echo '<p class="no-history" style="color: white; margin: 20px;">No login history found.</p>';
    }
    ?>
</body>
</html>
