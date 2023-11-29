<?php
session_start();
include 'php/db_connection.php';

if (isset($_POST['area_name']) && isset($_POST['division']) && isset($_POST['mla_name']) && isset($_POST['party'])) {
    $area_name = $_POST['area_name'];
    $division = $_POST['division'];
    $mla_name = $_POST['mla_name'];
    $party = $_POST['party'];

    
    $check_sql = "SELECT area_name FROM location WHERE area_name = '$area_name'";
    $check_result = mysqli_query($connection, $check_sql);

    if (mysqli_num_rows($check_result) > 0) {
        echo '<p style="color: red;">A location with the same area name already exists.</p>';
    } else {
        // Insert data into the "location" table
        $insert_sql = "INSERT INTO location (area_name, division, mla_name, party) VALUES ('$area_name', '$division', '$mla_name', '$party')";
    
        if (mysqli_query($connection, $insert_sql)) {
            echo '<p style="color: green;">Location data inserted successfully.</p>';
            
            // Use JavaScript to wait for 5 seconds and then redirect to the dashboard
            echo '<script>
                setTimeout(function() {
                    window.location.href = "dashboard.php";
                }, 5000);
            </script>';
        } else {
            echo '<p style="color: red;">Error: ' . mysqli_error($connection) . '</p>';
        }
    }
}

mysqli_close($connection);
?>

<head>
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
                    left: 550px;
                    
                    text-shadow: 2px 2px #000, /* Darker shadow */
                    4px 4px #444, /* Darker shadow */
                    6px 6px #666, /* Darker shadow */
                    8px 8px #888, /* Darker shadow */
                    10px 10px #aaa; /* Darker shadow */
                }
        </style>
</head>
<h1>Inserting into table</h1>
<div style="position: absolute; top: 80px; left: 600px; width: 300px; background-color: #f2f2f2; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px #888888;">
    <form method="POST" action="inserting.php">
        <label for="area_name" style="display: block; margin-top: 10px;">Area Name:</label>
        <input type="text" name="area_name" id="area_name" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px;">
        <label for="division" style="display: block;">Division:</label>
        <input type="text" name="division" id="division" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px;">
        <label for="mla_name" style="display: block;">MLA Name:</label>
        <input type="text" name="mla_name" id="mla_name" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px;">
        <label for="party" style="display: block;">Party:</label>
        <input type="text" name="party" id="party" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px;">
        <button type="submit" style="background-color: #007bff; color: white; border: none; padding: 10px 20px; margin-top: 10px; border-radius: 5px; cursor: pointer; width: 100%;">Insert Location</button>
    </form>
</div>

