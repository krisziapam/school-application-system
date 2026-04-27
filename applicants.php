<?php
include "config.php";

$sql = "SELECT * FROM applicant";
$result = mysqli_query($conn, $sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Applicants</title>
</head>
<body>

<h1>Applicants</h1>

<a href="add_applicant.php">Add Applicant</a>
<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Sex</th>
        <th>Email</th>
        <th>Phone</th>
    </tr>

    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <tr>
            <td><?php echo $row['applicant_id']; ?></td>
            <td><?php echo $row['first_name'] . " " . $row['last_name']; ?></td>
            <td><?php echo $row['sex']; ?></td>
            <td><?php echo $row['email']; ?></td>
            <td><?php echo $row['phone']; ?></td>
        </tr>
    <?php } ?>
</table>

<br>
<a href="index.php">Back</a>

</body>
</html>
