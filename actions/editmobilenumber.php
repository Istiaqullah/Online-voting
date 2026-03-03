<?php
session_start();
include('connect.php');

if (isset($_POST['NID'])) {
    $newNID = $_POST['NID'];
    $data = $_SESSION['data'];

    if (!preg_match('/^[0-9]{10}$/', $newNID)) //Perl-Compatible Regular Expression Match
    {  
        echo "<script>alert('Enter a valid 10-digit NID number.'); window.location='../pages/profile.php';</script>";
    } elseif ($newNID != $data['NID']) {
        $id = $data['UserID'];
        $sql = "UPDATE `users` SET NID='$newNID' WHERE UserID=$id";

        if (mysqli_query($con, $sql)) {
            $_SESSION['data']['NID'] = $newNID;
            echo "<script>alert('NID number updated successfully.'); window.location='../pages/profile.php';</script>";
        } else {
            echo "<script>alert('Failed to update NID number: " . mysqli_error($con) . "'); window.location='../pages/profile.php';</script>";
        }
    }
    else{
        echo "<script>alert('No Changes in NID number.'); window.location='../pages/profile.php';</script>";
    }
}

?>