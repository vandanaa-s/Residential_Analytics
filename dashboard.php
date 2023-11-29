<?php
session_start();
if (!isset($_SESSION['username'])) {
    header('Location: login.html');
    exit;
}

include 'php/db_connection.php';

if (isset($_GET['areaName'])) {
    $areaName = $_GET['areaName'];

    // Build and execute the SQL query to call the CalculateFuturePrice function
    $sql = "SELECT CalculateFuturePrice('$areaName') AS FuturePrice";
    $result = mysqli_query($connection, $sql);

    if ($result) {
        $row = mysqli_fetch_assoc($result);
        $futurePrice = $row['FuturePrice'];

        if ($futurePrice === null) {
            echo '<p style="color: black; font-weight: bold; font-size: 24px;">No data found.</p>';
        } else {
            echo '<p style="">Future Price: Rs. ' . number_format($futurePrice, 2) . '</p>';
        }
    } else {
        echo '<p style="color: red;">Error in SQL query: ' . mysqli_error($connection) . '</p>';
    }

    mysqli_close($connection);
    exit;
}
?>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <script src="js/script.js"></script>
</head>
<body class='dashboard-body'>
    
    <h1 class='dashboard-title'>RESIDENTIAL AREA ANALYTICS</h1>
    
    <h1 style="color:white">Welcome, <?php echo $_SESSION['username']; ?></h1>

    <!--DELETING AN ACCOUNT-->
    <div style="position: absolute; top: 168px; left: 900px">
        <?php
            // Retrieve the user's role
            $username = $_SESSION['username'];
            
            $sql = "SELECT role FROM users WHERE username='$username'";
            $result = mysqli_query($connection2, $sql); 
            
            if (mysqli_num_rows($result) > 0) {
                $row = mysqli_fetch_assoc($result);
                $userRole = $row['role'];
            
                // Display the "Delete Account" button for citizen users only
                if ($userRole === 'citizen') {
                
                    echo '<form method="POST" action="delete_account.php" onsubmit="return confirm(\'Are you sure you want to delete?\')">';
                    echo '<button type="submit" name="deleteAccount" style="background-color: red; color: white; padding: 10px 15px; border: none; border-radius: 5px;">Delete Account</button>';
                    echo '</form>';
                    
                }
            }
               
        ?>
    </div>

    <!--
        LOGIN HISTORY 
    -->
    <div style="position: absolute; top: 165px; left: 890px; z-index: 1;">
        <?php
        // Check the user's role
        $username = $_SESSION['username'];

        $sql = "SELECT role FROM users WHERE username='$username'";
        $result = mysqli_query($connection2, $sql); // Use the connection2 for user management


        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $userRole = $row['role'];

            // Display the "Login History" button for admin users
            if ($userRole === 'admin') {
                echo '<button style="background-color: red; color: white; padding: 8px; margin: 5px; border: none; border-radius: 5px;"><a href="login_history.php" class="login-history-button-text" style="text-decoration: none; color: white;">Login History</a></button>';
            }
        }

        mysqli_close($connection2);
        ?>
    </div>

    <!--CALCULATING FURURE VALUES-->
    <div style="position: absolute; top: 7px; left: 1290px; width: 200px; background-color: #45a049; color: white; padding: 10px; border-radius: 10px;">
    
        <form method="GET" >
            <label for="areaName" style="display: block; margin-bottom: 10px;">Future property price:</label>
            <select name="areaName" id="areaName" style="width: 100%; padding: 5px;">
                <?php
                // Include your database connection script
                include 'php/db_connection.php';

                // Query to retrieve area names from the database
                $sql = "SELECT area_name FROM property";
                $result = mysqli_query($connection, $sql);

                // Check if there are results
                if (mysqli_num_rows($result) > 0) {
                    while ($row = mysqli_fetch_assoc($result)) {
                        $areaName = $row['area_name'];
                        echo "<option value='$areaName'>$areaName</option>";
                    }
                }

                // Close the database connection
                mysqli_close($connection);
                ?>
            </select>
            <button type="submit" style="background-color: #1f7820; color: white; border: none; padding: 10px 20px; margin-top: 10px; border-radius: 5px; cursor: pointer; width: 100%;">Calculate</button>
        </form>
    </div>


    <!--
        PROCEDURE IMPLEMENTATION: check proximity to the airport
    -->
    <div style="position: absolute; top: 135px; left: 1290px; width: 200px; background-color: #45a049; color: white; padding: 10px; border-radius: 10px;">
        <form method="GET" action="order-by-airport.php">
            <button type="submit" name="order-by-airport" style="background-color: #1f7820; color: white; border: none; padding: 10px 20px; margin-top: 10px; border-radius: 5px; cursor: pointer; width: 100%;">Order by Airport Proximity</button>
        </form>
    </div>


    

    <?php
    include 'php/db_connection.php';
    $sql = "SHOW TABLES";
    $result = mysqli_query($connection, $sql);
    $tableNames = array();

    if (mysqli_num_rows($result) > 0) {
        while ($row = mysqli_fetch_row($result)) {
            $tableName = $row[0];
            $tableNames[] = $tableName;
        }
    }

    mysqli_close($connection);
    ?>

    <div class="table-buttons">
        <?php
        foreach ($tableNames as $tableName) {
            echo '<button class="tab-button" data-table="' . $tableName . '">' . $tableName . '</button>';
        }
        ?>
    </div>
    
    
    <!--
        DISPLAYING ALL THE TABLES : DASHBOARD INTRO
    -->
    <div class="table-content-container">
        <?php
        include 'php/db_connection.php';

        foreach ($tableNames as $tableName) {
            echo '<div class="tab-content" id="' . $tableName . '-content">';
            $sql = "SELECT * FROM $tableName";
            $result = mysqli_query($connection, $sql);

            if (mysqli_num_rows($result) > 0) {
                echo '<table border="1">';
                while ($tableRow = mysqli_fetch_assoc($result)) {
                    echo '<tr class="table-row">';
                    foreach ($tableRow as $column => $value) {
                        if ($value === NULL) {
                            $value = 'No information available';
                        }
                        echo "<td class='table-cell'><span class='column'>$column:</span> $value</td>";
                    }
                    echo '</tr>';
                }

                echo '</table>';
            } else {
                echo 'No data found.';
            }
            echo '</div>';
        }
        mysqli_close($connection);
        ?>
    </div>



    <div style="position: absolute; top: 10px; left: 1180px; padding: 10px">
        <button id="showFormButton" style="background-color: #1f7820; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;width: 90px">
            Insert
        </button>
    </div>

    <div style="position: absolute; top: 60px; left: 1170px; padding: 10px 20px;">
        <form method="GET" action="queries.php">
            <button type="submit" name="queries" style="background-color: #1f7820; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;width: 90px">
                Queries
            </button>
        </form>
    </div>

    <div style="position: absolute; top: 110px; left: 1170px; padding: 10px 20px;">
        
        <button id="updateButton" type="submit" style="background-color: #1f7820; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s; width: 90px;">
            Update
        </button>
        
    </div>



<script>
document.getElementById("showFormButton").addEventListener("click", function() {
    // Check if the user has 'admin' role to allow insertion
    if ("<?php echo $userRole; ?>" === "admin") {
        window.location.href = "inserting.php"; // Redirect to inserting.php when "Insert" is clicked for admin
    } else {
        alert("You don't have the permissions to insert."); // Display message for non-admin users
    }
}); 

document.getElementById("updateButton").addEventListener("click", function() {
    // Check if the user has 'admin' role to allow insertion
    if ("<?php echo $userRole; ?>" === "admin") {
        window.location.href = "update.php"; // Redirect to inserting.php when "Insert" is clicked for admin
    } else {
        alert("You don't have the permissions to update."); // Display message for non-admin users
    }
}); 
</script>



</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
// Function to hide tables
function hideTables() {
    $(".tab-content").hide();
}

$(document).ready(function () {
    hideTables(); // Call the function to hide all tables
    $(".tab-button").click(function () {
        var tableId = $(this).data("table");
        $(".tab-content").hide();
        $("#" + tableId + "-content").show();
    });
});
</script>
</html>