<?php
// Database connection details
$servername = "db";
$username = "user";
$password = "password";
$dbname = "testdb";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Perform a write operation (insert random data for testing)
$sql = "INSERT INTO test_table (data) VALUES ('Sample Data " . rand(1, 100) . "')";
if ($conn->query($sql) === TRUE) {
    echo "New record created successfully<br>";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// Perform a read operation (selecting all entries from the table)
$sql = "SELECT id, data FROM test_table";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<h2>Data from test_table:</h2>";
    // Output data of each row
    while($row = $result->fetch_assoc()) {
        echo "ID: " . $row["id"]. " - Data: " . $row["data"]. "<br>";
    }
} else {
    echo "0 results";
}

// Close the connection
$conn->close();
?>
