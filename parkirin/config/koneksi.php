<?php

mysqli_report(MYSQLI_REPORT_OFF);
date_default_timezone_set('Asia/Jakarta');

$envFile = dirname(__DIR__) . '/.env';
$envConfig = is_file($envFile) ? parse_ini_file($envFile, false, INI_SCANNER_RAW) : array();
$envConfig = is_array($envConfig) ? $envConfig : array();

$host = getenv('DB_HOST') ?: ($envConfig['DB_HOST'] ?? '127.0.0.1');
$user = getenv('DB_USER') ?: ($envConfig['DB_USER'] ?? 'root');
$environmentPassword = getenv('DB_PASS');
$pass = $environmentPassword !== false ? $environmentPassword : ($envConfig['DB_PASS'] ?? '');
$db = getenv('DB_NAME') ?: ($envConfig['DB_NAME'] ?? 'parkirin');
$port = (int) (getenv('DB_PORT') ?: ($envConfig['DB_PORT'] ?? 3306));

$conn = mysqli_connect($host, $user, $pass, $db, $port);

if (!$conn) {
    error_log('PARKIRIN database connection failed: ' . mysqli_connect_error());
    http_response_code(500);
    exit('Koneksi database gagal. Periksa konfigurasi database pada server.');
}

if (!mysqli_set_charset($conn, 'utf8mb4')) {
    error_log('PARKIRIN failed to set utf8mb4: ' . mysqli_error($conn));
    http_response_code(500);
    exit('Pengaturan karakter database gagal.');
}
