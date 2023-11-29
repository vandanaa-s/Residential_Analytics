<?php
session_start();
if (!isset($_SESSION['username'])) {
    header('Location: login.html');
    exit;
}

include 'php/db_connection.php';

$areaName = "";
$currentValue = "";
$updateMessage = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    if (isset($_POST['select_option'])) {
        $areaName = mysqli_real_escape_string($connection, $_POST['area_name']);
    }

    if (isset($_POST['update_value'])) {
        $areaName = mysqli_real_escape_string($connection, $_POST['area_name']);
        $newValue = mysqli_real_escape_string($connection, $_POST['new_value']);
    
        if ($areaName && $newValue) {
            $table = mysqli_real_escape_string($connection, $_POST['table_option']);
            $columnOption = mysqli_real_escape_string($connection, $_POST['column_option']);
    
            try {
                // Construct and execute the SQL query to update the selected column
                $sql = "UPDATE $table SET $columnOption = '$newValue' WHERE area_name = '$areaName'";
                if (mysqli_query($connection, $sql)) {
                    $updateMessage = "$columnOption updated successfully for $areaName.";
                } else {
                    $updateMessage = 'Error updating.';
                }
            } catch (Exception $e) {
                $updateMessage = 'TRIGGER: CANT ENTER A PRICE BELOW 2500.';
            }
        } else {
            $updateMessage = 'Please select an area, provide a new value, and choose a column.';
        }
    }
    

    // Fetch the current value
    $sqlProperty = "SELECT price_range, growth_rate FROM property WHERE area_name = '$areaName'";
    $sqlSafety = "SELECT crime_rate FROM safety_and_security WHERE area_name = '$areaName'";
    $resultProperty = mysqli_query($connection, $sqlProperty);
    $resultSafety = mysqli_query($connection, $sqlSafety);

    if (mysqli_num_rows($resultProperty) > 0) {
        $rowProperty = mysqli_fetch_assoc($resultProperty);
        $currentPriceRange = $rowProperty['price_range'];
        $currentGrowthRate = $rowProperty['growth_rate'];
    }

    if (mysqli_num_rows($resultSafety) > 0) {
        $rowSafety = mysqli_fetch_assoc($resultSafety);
        $currentCrimeRate = $rowSafety['crime_rate'];
    }
}

?>

<script>
function updateColumnOptions() {
    var tableOption = document.getElementById('table_option');
    var columnOption = document.getElementById('column_option');
    
    if (tableOption.value === 'property') {
        columnOption.innerHTML = '<option value="price_range">Price Range</option><option value="growth_rate">Growth Rate</option>';
    } else if (tableOption.value === 'safety_and_security') {
        columnOption.innerHTML = '<option value="crime_rate">Crime Rate</option>';
    }
}
</script>

<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Data</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        h1 {
            position: relative;
            display: inline-block;
            font-size: 36px;
            font-weight: 800;
            text-transform: uppercase;
            font-style: italic;
            color: transparent;
            -webkit-text-stroke-width: 1.8px;
            -webkit-text-stroke-color: #333; /* Darker color for text stroke */
            white-space: nowrap;
            margin: 0 auto; /* Center align */
            left: 650px;
            
            text-shadow: 2px 2px #000, /* Darker shadow */
            4px 4px #444, /* Darker shadow */
            6px 6px #666, /* Darker shadow */
            8px 8px #888, /* Darker shadow */
            10px 10px #aaa; /* Darker shadow */
        }


        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        form {
            margin: 20px 0;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        select,
        input {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        button:hover {
            background-color: #555;
        }

        .message {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            background-color: #f9f9f9;
        }
    </style>
</head>

<body>
    <h1>Update Data</h1>

    <div class="container">
        <form method="POST">
            <label for="table_option">Select Table:</label>
            <select name="table_option" id="table_option" onchange="updateColumnOptions()">
                <option value="property">Property</option>
                <option value="safety_and_security">Safety and Security</option>
            </select>

            <label for="area_name">Select Area Name:</label>
            <select name="area_name" id="area_name">
                <?php
                $table = (isset($_POST['table_option'])) ? $_POST['table_option'] : 'property';
                $sql = "SELECT area_name FROM $table";
                $result = mysqli_query($connection, $sql);

                if (mysqli_num_rows($result) > 0) {
                    while ($row = mysqli_fetch_assoc($result)) {
                        $name = $row['area_name'];
                        echo "<option value='$name'>$name</option>";
                    }
                }
                ?>
            </select>

            <label for="column_option">Select Column to Update:</label>
            <select name="column_option" id="column_option">
                <?php
                $table = (isset($_POST['table_option'])) ? $_POST['table_option'] : 'property';
                if ($table === 'property') {
                    echo '<option value="price_range">Price Range</option>';
                    echo '<option value="growth_rate">Growth Rate</option>';
                } elseif ($table === 'safety_and_security') {
                    echo '<option value="crime_rate">Crime Rate</option>';
                }
                ?>
            </select>

            <label for="new_value">Enter New Value:</label>
            <input type="text" name="new_value" id="new_value" placeholder="New Value">

            <button type="submit" name="update_value">Update</button>
        </form>

        <div class="message">
            <?php
            if (isset($_POST['table_option']) && $_POST['table_option'] === 'property') {
                echo "Current Price Range: $currentPriceRange";
                echo "<br>Current Growth Rate: $currentGrowthRate";
            } elseif (isset($_POST['table_option']) && $_POST['table_option'] === 'safety_and_security') {
                echo "Current Crime Rate: $currentCrimeRate";
            }
            echo "<br>$updateMessage";
            ?>
        </div>
    </div>

</body>

</html>
