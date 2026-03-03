<?php
include("./connect.php");

// 1. Validate required fields
if (
    !isset($_POST['title'], $_POST['description'], $_POST['start_date'], $_POST['end_date'], $_POST['position_name']) ||
    empty($_POST['title']) || empty($_POST['description']) || empty($_POST['start_date']) || empty($_POST['end_date']) || empty($_POST['position_name'])
) {
    echo "<script>alert('All fields are required.'); window.location='../pages/createElection.php';</script>";
    exit();
}

$title = trim($_POST['title']);
$description = trim($_POST['description']);
$start_date = trim($_POST['start_date']);
$end_date = trim($_POST['end_date']);
$positionTitle = trim($_POST['position_name']);
$positionDescription = "Some Position Description"; // Modify as needed

// 2. Check for duplicate election
$check_title_sql = "SELECT Title, Status FROM Elections WHERE Title = ?";
$stmt = $con->prepare($check_title_sql);
$stmt->bind_param("s", $title);
$stmt->execute();
$checkResult = $stmt->get_result();
if ($checkResult && $checkResult->num_rows > 0) {
    echo "<script>alert('An election with this title already exists!'); window.location='../pages/createElection.php';</script>";
    exit();
}
$stmt->close();

// 3. Insert into Elections table
$insert_election_sql = "INSERT INTO Elections (Title, Description, Start_Date, End_Date) VALUES (?, ?, ?, ?)";
$stmt = $con->prepare($insert_election_sql);
if (!$stmt) {
    echo "Error in statement: " . $con->error;
    exit();
}
$stmt->bind_param("ssss", $title, $description, $start_date, $end_date);

if (!$stmt->execute()) {
    echo "Error inserting election: " . $stmt->error;
    exit();
}

$lastInsertedID = $stmt->insert_id;
$stmt->close();

// 4. Compute and update status
$current_date = date('Y-m-d');
if ($current_date < $start_date) {
    $status = "Upcoming";
} elseif ($current_date >= $start_date && $current_date <= $end_date) {
    $status = "Ongoing";
} else {
    $status = "Ended";
}

// Update status in Elections
$update_status_sql = "UPDATE Elections SET Status = ? WHERE ElectionID = ?";
$stmt = $con->prepare($update_status_sql);
if ($stmt) {
    $stmt->bind_param("si", $status, $lastInsertedID);
    $stmt->execute();
    $stmt->close();
} // else ignore; status is optional

// 5. Insert into Positions table
$insert_position_sql = "INSERT INTO Positions (ElectionID, Title, Description) VALUES (?, ?, ?)";
$stmt = $con->prepare($insert_position_sql);
if (!$stmt) {
    echo "Error preparing position statement: " . $con->error;
    exit();
}
$stmt->bind_param("iss", $lastInsertedID, $positionTitle, $positionDescription);

if ($stmt->execute()) {
    echo '<script>
        alert("Election and Position created successfully!");
        window.location="../pages/createElection.php";
    </script>';
} else {
    echo "Error inserting data into Positions table: " . $stmt->error;
}
$stmt->close();
$con->close();

?>