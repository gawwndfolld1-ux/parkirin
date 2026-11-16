PARKIRIN - Panduan Menjalankan di VS Code dan XAMPP
====================================================

KEBUTUHAN
- XAMPP dengan Apache, MySQL/MariaDB, dan PHP.
- VS Code (opsional, untuk mengedit kode).
- Ekstensi PHP di VS Code boleh digunakan untuk membantu penulisan kode.

CARA MENJALANKAN
1. Ekstrak folder `parkirin` dari ZIP.
2. Salin folder `parkirin` ke dalam `C:\xampp\htdocs\`.
   Pastikan hasilnya: `C:\xampp\htdocs\parkirin\index.php`.
3. Buka XAMPP Control Panel, lalu Start Apache dan MySQL.
4. Buka `http://localhost/phpmyadmin`.
5. Buat database bernama `parkirin` dengan collation `utf8mb4_unicode_ci`.
6. Pilih database `parkirin`, klik tab Import, pilih file `database/parkirin.sql`, lalu klik Import/Go.
   Script ini tidak menghapus tabel atau data yang sudah ada ketika diimpor ulang.
7. Periksa `config/koneksi.php`. Konfigurasi bawaan XAMPP:
   host=localhost, user=root, password kosong, port=3306, database=parkirin.
   Jika MySQL XAMPP memakai port lain atau password root sudah diubah, sesuaikan file ini.
8. Buka `http://localhost/parkirin/`.

AKUN UJI COBA
- Admin:   username `alea`,    password `alea`
- Petugas: username `baskara`, password `baskara`
- Owner:   username `camila`,  password `camila`
- Petugas tambahan: `dayat`, `emily`, `fawas` (password sama dengan username).

CATATAN
- Login awal memakai password contoh sederhana. Ganti password melalui menu Ganti Password setelah login.
- Jalankan Apache dan MySQL dari XAMPP sebelum membuka aplikasi.
- Jika muncul error koneksi, pastikan database `parkirin` sudah dibuat dan diimpor, lalu cek port serta password di `config/koneksi.php`.
- Jangan mengunggah file database yang berisi data asli ke repositori publik.
- Aplikasi memakai MySQLi dan struktur OOP sederhana; tidak menggunakan PDO.
