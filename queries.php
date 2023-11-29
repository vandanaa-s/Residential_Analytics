<?php
include 'php/db_connection.php';

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['query'])) {
        $queryName = $_POST['query'];

        switch ($queryName) {
            case 'High Crime Rate':
                $sql = "SELECT area_name FROM safety_and_security WHERE crime_rate = 'High'";
                break;
            case 'Hindu Cultural Diversity':
                $sql = "SELECT area_name, population_density FROM demography WHERE cultural_diversity = 'Hindu'";
                break;
            case 'Very Poor Air Quality':
                $sql = "SELECT area_name FROM external_factors WHERE aqi = 'Very Poor'";
                break;
            case 'Areas with Minimum Rental Rate':
                $sql = "SELECT area_name, property_type FROM property WHERE rental_rate = (SELECT MIN(rental_rate) FROM property)";
                break;
            case 'Areas with High Crime Rate and Above Average Airport Proximity':
                $sql = "SELECT area_name FROM transport WHERE airport_proximity > (SELECT AVG(airport_proximity)FROM transport WHERE area_name IN (SELECT area_name FROM safety_and_security WHERE crime_rate = 'High'))";
                break;
            case 'Areas with Above Avergae Population Density and Maximum Infrastructure':
                $sql = "SELECT l.area_name, d.population_density FROM location l JOIN demography d ON l.area_name = d.area_name WHERE d.population_density > (SELECT AVG(population_density)FROM demography)AND l.area_name IN (SELECT DISTINCT i.area_name FROM infrastructure i WHERE i.schools IS NOT NULL AND i.hospitals IS NOT NULL AND i.colleges IS NOT NULL AND i.malls IS NOT NULL)";
                break;
            case 'Areas With Growth Rates Higher Than Their Divisions Average Growth Rate':
                $sql = "SELECT p1.area_name, p1.growth_rate FROM property p1 INNER JOIN location l ON p1.area_name = l.area_name WHERE p1.growth_rate > (SELECT AVG(p2.growth_rate)FROM property p2 INNER JOIN location l2 ON p2.area_name = l2.area_name WHERE l2.division = l.division)";
                break;
            case 'Areas With High Crime Rates And No Hospitals':
                $sql = "SELECT ss.area_name FROM safety_and_security ss WHERE ss.crime_rate = 'High' AND NOT EXISTS (SELECT *FROM infrastructure i WHERE i.area_name = ss.area_name AND i.hospitals IS NOT NULL);";
                break;
            case 'Divisions with Average Population Density Above 2700 persons/sqkm':
                $sql = "SELECT division, AVG(population_density) AS avg_density FROM location l JOIN demography d ON l.area_name = d.area_name GROUP BY division HAVING avg_density > 27";
                break;
            case 'Property Types With Average Price Above 9000/sqft':
                $sql = "SELECT property_type, AVG(price_range) AS avg_price_range FROM property GROUP BY property_type HAVING avg_price_range > 9000";
                break;
            default:
                echo "Invalid query name.";
                exit;
        }

        $result = mysqli_query($connection, $sql);

        if ($result) {
            echo "<h2>Query Results for $queryName:</h2>";

            if (mysqli_num_rows($result) > 0) {
                echo "<table border='1'>";
                if ($queryName === 'High Crime Rate') {
                    echo "<tr><th>Area Name</th></tr>";
                } elseif ($queryName === 'Hindu Cultural Diversity') {
                    echo "<tr><th>Area Name</th><th>Population Density</th></tr>";
                } elseif ($queryName === 'Very Poor Air Quality') {
                    echo "<tr><th>Area Name</th></tr>";
                } elseif ($queryName === 'Areas with Minimum Rental Rate') {
                    echo "<tr><th>Area Name</th><th>Property Type</th></tr>";
                } elseif ($queryName === 'Areas with High Crime Rate and Above Average Airport Proximity') {
                    echo "<tr><th>Area Name</th></tr>";
                } elseif ($queryName === 'Areas with Above Avergae Population Density and Maximum Infrastructure') {
                    echo "<tr><th>Area Name</th><th>Population Density</th></tr>";
                } elseif ($queryName === 'Areas With Growth Rates Higher Than Their Divisions Average Growth Rate') {
                    echo "<tr><th>Area Name</th><th>Growth Rate</th></tr>";
                } elseif ($queryName === 'Areas With High Crime Rates And No Hospitals') {
                    echo "<tr><th>Area Name</th></tr>";
                } elseif ($queryName === 'Divisions with Average Population Density Above 2700 persons/sqkm') {
                    echo "<tr><th>Division</th><th>Average Density</th></tr>";
                } elseif ($queryName === 'Property Types With Average Price Above 9000/sqft') {
                    echo "<tr><th>Property Type</th><th>Average Price</th></tr>";
                }
                while ($row = mysqli_fetch_assoc($result)) {
                    echo "<tr>";
                    if ($queryName === 'High Crime Rate') {
                        echo "<td>" . $row['area_name'] . "</td>";
                    } elseif ($queryName === 'Hindu Cultural Diversity') {
                        echo "<td>" . $row['area_name'] . "</td>";
                        echo "<td>" . $row['population_density'] . "</td>";
                    } elseif ($queryName === 'Very Poor Air Quality') {
                        echo "<td>" . $row['area_name'] . "</td>";
                    } elseif ($queryName === 'Areas with Minimum Rental Rate') {
                        echo "<td>" . $row['area_name'] . "</td>";
                        echo "<td>" . $row['property_type'] . "</td>";
                    } elseif ($queryName === 'Areas with High Crime Rate and Above Average Airport Proximity') {
                        echo "<td>" . $row['area_name'] . "</td>";
                    } elseif ($queryName === 'Areas with Above Avergae Population Density and Maximum Infrastructure') {
                        echo "<td>" . $row['area_name'] . "</td>";
                        echo "<td>" . $row['population_density'] . "</td>";
                    } elseif ($queryName === 'Areas With Growth Rates Higher Than Their Divisions Average Growth Rate') {
                        echo "<td>" . $row['area_name'] . "</td>";
                        echo "<td>" . $row['growth_rate'] . "</td>";
                    } elseif ($queryName === 'Areas With High Crime Rates And No Hospitals') {
                        echo "<td>" . $row['area_name'] . "</td>";
                    } elseif ($queryName === 'Divisions with Average Population Density Above 2700 persons/sqkm') {
                        echo "<td>" . $row['division'] . "</td>";
                        echo "<td>" . $row['avg_density'] . "</td>";
                    } elseif ($queryName === 'Property Types With Average Price Above 9000/sqft') {
                        echo "<td>" . $row['property_type'] . "</td>";
                        echo "<td>" . $row['avg_price_range'] . "</td>";
                    }
                    echo "</tr>";
                }
                echo "</table>";
            } else {
                echo "No results found.";
            }
        } else {
            echo "Error in SQL query: " . mysqli_error($connection);
        }

        mysqli_close($connection);
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Execute Queries</title>
</head>
<body>
    <h1>Execute Queries</h1>

    <form method="post">
        <label for="query">Select a Query:</label>
        <select name="query" id="query">
            <option value="High Crime Rate">Simple Query 1</option>
            <option value="Hindu Cultural Diversity">Simple Query 2</option>
            <option value="Very Poor Air Quality">Simple Query 3</option>
            <option value="Areas with Minimum Rental Rate">Simple Query 4</option>
            <option value="Areas with High Crime Rate and Above Average Airport Proximity">Nested Query 1</option>
            <option value="Areas with Above Avergae Population Density and Maximum Infrastructure">Nested Query 2</option>
            <option value="Areas With Growth Rates Higher Than Their Divisions Average Growth Rate">Correlated Query 1</option>
            <option value="Areas With High Crime Rates And No Hospitals">Correlated Query 2</option>
            <option value="Divisions with Average Population Density Above 2700 persons/sqkm">Aggregate Query 1</option>
            <option value="Property Types With Average Price Above 9000/sqft">Aggregate Query 2</option>
        </select>
        <button type="submit">Execute Query</button>
    </form>

</body>
</html>
