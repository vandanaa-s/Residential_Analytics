<?php
include 'db_connection.php';

if (isset($_POST['signup-submit'])) {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $date_of_birth = $_POST['date_of_birth']; 


    // Get the registration password provided by the user
    $registrationPassword = $_POST['registration_password'];
    

    // Set the default role to "citizen"
    $role = "citizen";

    // Check if the provided registration password matches the admin registration password
    if ($registrationPassword === "vndn") {
        $role = "admin";
    }

    // Hash the password (use a stronger hashing method in production)
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    // Create an INSERT INTO query to add a new user
    $sql = "INSERT INTO users (username, email, password, date_of_birth,role) VALUES ('$username', '$email', '$hashedPassword', '$date_of_birth','$role')";

    if (mysqli_query($connection2, $sql)) {
        echo "Registration successful!";
        // JavaScript code to redirect after 5 seconds
        echo '<script>
            setTimeout(function() {
                window.location.href = "../index.html"; // Change this URL to your main page
            }, 5000); // 5000 milliseconds (5 seconds)
        </script>';
    } else {
        echo "Error: " . $sql . "<br>" . mysqli_error($connection2);
    }
}

mysqli_close($connection2);
?>



