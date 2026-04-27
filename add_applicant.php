<?php
include "config.php";

/*
    Campus dropdown:
    This removes duplicate campus names like "Main Campus" showing 3 times.
*/
$campuses = mysqli_query($conn, "
    SELECT MIN(campus_id) AS campus_id, campus_name
    FROM campus
    GROUP BY campus_name
    ORDER BY campus_name
");

/*
    Educational background dropdown:
    This gets all educational background records.
*/
$categories = mysqli_query($conn, "
    SELECT *
    FROM educational_background_category
");

/*
    This function prevents blank dropdown text.
    It automatically finds the first readable column value besides the ID.
*/
function getDisplayName($row, $idColumn) {
    $preferredColumns = [
        'category_name',
        'educational_background_category_name',
        'name',
        'description',
        'level',
        'background_name'
    ];

    foreach ($preferredColumns as $column) {
        if (isset($row[$column]) && !empty($row[$column])) {
            return $row[$column];
        }
    }

    foreach ($row as $column => $value) {
        if ($column !== $idColumn && !empty($value)) {
            return $value;
        }
    }

    return "No name";
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Add Applicant</title>
</head>
<body>

<h1>Add Applicant</h1>

<form action="save_applicant.php" method="POST">

    <label>First Name:</label><br>
    <input type="text" name="first_name" required><br><br>

    <label>Middle Name:</label><br>
    <input type="text" name="middle_name"><br><br>

    <label>Last Name:</label><br>
    <input type="text" name="last_name" required><br><br>

    <label>Sex:</label><br>
    <select name="sex" required>
        <option value="">Select Sex</option>
        <option value="Male">Male</option>
        <option value="Female">Female</option>
    </select><br><br>

    <label>Birth Date:</label><br>
    <input type="date" name="birth_date"><br><br>

    <label>Email:</label><br>
    <input type="email" name="email"><br><br>

    <label>Phone:</label><br>
    <input type="text" name="phone"><br><br>

    <label>Campus:</label><br>
    <select name="campus_id" required>
        <option value="">Select Campus</option>

        <?php while ($campus = mysqli_fetch_assoc($campuses)) { ?>
            <option value="<?php echo $campus['campus_id']; ?>">
                <?php echo $campus['campus_name']; ?>
            </option>
        <?php } ?>

    </select><br><br>

    <label>Educational Background:</label><br>
    <select name="educational_background_category_id" required>
        <option value="">Select Educational Background</option>

        <?php while ($category = mysqli_fetch_assoc($categories)) { ?>
            <option value="<?php echo $category['educational_background_category_id']; ?>">
                <?php echo getDisplayName($category, 'educational_background_category_id'); ?>
            </option>
        <?php } ?>

    </select><br><br>

    <button type="submit">Save Applicant</button>

</form>

<br>
<a href="applicants.php">Back to Applicants</a>

</body>
</html>
