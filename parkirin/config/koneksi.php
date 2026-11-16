<?php

mysqli_report(MYSQLI_REPORT_OFF);

$host = 'localhost';
$user = 'root';
$pass = '';
$db   = 'parkirin';
$port = 3306;

$conn = mysqli_connect($host, $user, $pass, $db, $port);

if (!$conn) {
    http_response_code(500);
    die('Koneksi database PARKIRIN gagal. Pastikan MySQL di XAMPP sudah berjalan, database parkirin sudah diimpor melalui phpMyAdmin, dan pengaturan config/koneksi.php sudah benar. Detail: ' . htmlspecialchars(mysqli_connect_error(), ENT_QUOTES, 'UTF-8'));
}

if (!mysqli_set_charset($conn, 'utf8mb4')) {
    http_response_code(500);
    die('Gagal mengatur charset database: ' . htmlspecialchars(mysqli_error($conn), ENT_QUOTES, 'UTF-8'));
}

?>
