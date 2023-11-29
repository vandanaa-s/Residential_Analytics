<?php
include 'php/db_connection.php';

// Check if the "order-by-airport" parameter is set
if (isset($_GET['order-by-airport'])) {
    // Call the stored procedure
    $sql = "CALL OrderAreasByAirportProximity()";
    $result = mysqli_query($connection, $sql);

    if ($result) {
        echo '<div class="black-background">'; // Apply black background
        echo '<h3 style="color:white;">Areas Ordered by Airport Proximity:</h3>';
        echo '<table class="result-table">';
        echo '<tr><th>Area Name</th><th>Airport Proximity (km)</th><th>Metro Available</th><th>Railway Available</th><th>Bus Stops Available</th></tr>';

        while ($row = mysqli_fetch_assoc($result)) {
            echo '<tr>';
            echo '<td>' . $row['area_name'] . '</td>';
            echo '<td>' . $row['airport_proximity'] . '</td>';
            echo '<td>' . $row['metro_available'] . '</td>';
            echo '<td>' . $row['railway_available'] . '</td>';
            echo '<td>' . $row['bus_stops_available'] . '</td>';
            echo '</tr>';
        }

        echo '</table>';
        echo '</div>'; // Close the black background
    } else {
        echo '<p style="color: red;">Error in SQL query: ' . mysqli_error($connection) . '</p>';
    }
}

mysqli_close($connection);
?>

<style>
.black-background {
    background-color: black;
    padding: 20px; /* Add padding to create space around the table */
}

.result-table {
    border-collapse: separate;
    border-spacing: 2px;
    border: 4px double white;
    color: white;
}

.result-table th {
    border: 2px double white;
    padding: 10px;
    text-align: left;
}

.result-table td {
    border: 2px double white;
    padding: 10px;
}
</style>
