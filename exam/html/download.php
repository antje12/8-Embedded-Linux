<?php
if (isset($_GET['file'])) {
    $filename = $_GET['file'];
    $file = '/home/pi/scripts/exam/logs/' . $filename; // Specify the path to your directory and append the file name
    if (file_exists($file)) {
        // Set headers
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename="' . $filename . '"');
        header('Content-Length: ' . filesize($file));

        // Read and output the file content
        readfile($file);

        // Exit the script
        exit();
    } else {
        echo 'File not found.';
    }
} else {
    echo 'File name not specified.';
}
?>
