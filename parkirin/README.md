# PARKIRIN

Aplikasi manajemen parkir hotel berbasis PHP native (OOP) dan MySQLi.

## Kebutuhan

- PHP 8.0 atau lebih baru (disarankan PHP 8.2+)
- MySQL 5.7+ atau MariaDB 10.4+
- Ekstensi PHP `mysqli`
- Apache (XAMPP atau hosting berbasis Apache)

## Menjalankan di Windows dengan VS Code + XAMPP

1. Ekstrak folder `parkirin` ke `C:\\xampp\\htdocs\\parkirin`.
2. Buka XAMPP Control Panel, lalu Start **Apache** dan **MySQL**.
3. Buka `http://localhost/phpmyadmin`.
4. Buat database bernama `parkirin` dengan collation `utf8mb4_unicode_ci`.
5. Pilih database `parkirin`, lalu Import file `database/parkirin.sql`.
6. Periksa `config/koneksi.php`. Default lokal XAMPP adalah host `127.0.0.1`, user `root`, password kosong, database `parkirin`, port `3306`.
7. Buka `http://localhost/parkirin/`.

### Akun demo lokal

| Role | Username | Password awal |
|---|---|---|
| Admin | `alea` | `alea` |
| Petugas | `baskara` | `baskara` |
| Owner | `camila` | `camila` |
| Petugas | `dayat` | `dayat` |
| Petugas | `emily` | `emily` |
| Petugas | `fawas` | `fawas` |

Password di database sudah disimpan menggunakan `password_hash`. Segera ganti seluruh password demo setelah login dan jangan gunakan akun demo di website publik.

## Database yang sudah pernah dipakai

Jangan import `database/parkirin.sql` ke database berisi data penting karena file tersebut ditujukan untuk instalasi baru. Backup database terlebih dahulu. Untuk menyesuaikan panjang kolom password pada database lama, jalankan `database/migrasi_password.sql`. Password teks biasa dari versi lama akan di-hash otomatis ketika akun tersebut berhasil login dengan versi aplikasi ini.

Untuk penambahan kategori pemilik kendaraan pada database lama, gunakan `database/migrasi_kategori_pemilik.sql` hanya jika kolom `kategori_pemilik` memang belum ada. Jangan menjalankan migrasi yang sama dua kali.

## Konfigurasi hosting

1. Pastikan hosting mendukung PHP 8+ dan MySQL/MariaDB serta ekstensi `mysqli`.
2. Buat database dan user database dari panel hosting, lalu berikan hak akses user ke database tersebut.
3. Import `database/parkirin.sql` untuk instalasi baru. Jika database lama, backup dan jalankan migrasi yang sesuai.
4. Upload isi folder proyek ke document root domain/subdomain (umumnya `public_html`). Pastikan `index.php` berada langsung di document root.
5. Atur variabel lingkungan berikut melalui panel hosting jika tersedia:
   - `DB_HOST` = hostname MySQL dari hosting
   - `DB_USER` = user database hosting
   - `DB_PASS` = password database hosting
   - `DB_NAME` = nama database hosting
   - `DB_PORT` = port MySQL (umumnya `3306`)
6. Jika hosting tidak menyediakan environment variables, ubah nilai default pada `config/koneksi.php` sesuai detail database hosting. Jangan commit kredensial hosting ke GitHub.
7. Aktifkan SSL/HTTPS dari panel hosting dan uji login serta semua alur aplikasi.

## GitHub

File `.gitignore` sudah mengecualikan file environment dan file lokal. Sebelum push, pastikan tidak ada password database, file backup, atau data pengguna asli di repository. Untuk upload pertama:

```bash
git init
git add .
git commit -m "Initial PARKIRIN application"
git branch -M main
git remote add origin https://github.com/USERNAME/NAMA-REPOSITORY.git
git push -u origin main
```

Ganti URL remote dengan URL repository milikmu. GitHub hanya menyimpan source code; GitHub biasa tidak menjalankan PHP/MySQL. Aplikasi tetap perlu hosting PHP dan database.

## Catatan keamanan

- Ganti semua password demo sebelum aplikasi online.
- Gunakan kredensial database khusus hosting, bukan akun root.
- Jangan mengunggah `.env`, dump database berisi data pribadi, atau kredensial.
- Gunakan HTTPS.
- Lakukan backup sebelum migrasi atau pembaruan aplikasi.
