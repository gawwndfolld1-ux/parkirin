
-- DATABASE PARKIRIN
-- Pilih database hosting terlebih dahulu di phpMyAdmin.
-- Aman diimpor ulang: tabel dan data yang sudah ada tidak dihapus.

CREATE TABLE IF NOT EXISTS tb_user (
  id_user INT(11) NOT NULL AUTO_INCREMENT,
  nama_lengkap VARCHAR(50) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  role ENUM('admin','petugas','owner') NOT NULL,
  status_aktif TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id_user)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tb_tarif (
  id_tarif INT(11) NOT NULL AUTO_INCREMENT,
  jenis_kendaraan ENUM('motor','mobil','lainnya') NOT NULL,
  tarif_per_jam DECIMAL(10,0) NOT NULL DEFAULT 0,
  PRIMARY KEY (id_tarif),
  UNIQUE KEY uq_tarif_jenis (jenis_kendaraan)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tb_area_parkir (
  id_area INT(11) NOT NULL AUTO_INCREMENT,
  nama_area VARCHAR(50) NOT NULL,
  kapasitas INT(5) NOT NULL DEFAULT 0,
  terisi INT(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (id_area),
  UNIQUE KEY uq_area_nama (nama_area)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tb_kendaraan (
  id_kendaraan INT(11) NOT NULL AUTO_INCREMENT,
  plat_nomor VARCHAR(15) NOT NULL,
  jenis_kendaraan VARCHAR(20) NOT NULL,
  warna VARCHAR(20) DEFAULT NULL,
  pemilik VARCHAR(100) NOT NULL COMMENT 'Nama pemilik atau pengguna kendaraan',
  kategori_pemilik ENUM('owner','admin','petugas','penghuni_tetap','tamu_pendatang') NOT NULL DEFAULT 'tamu_pendatang',
  id_user INT(11) NOT NULL COMMENT 'User aplikasi yang mencatat data kendaraan',
  PRIMARY KEY (id_kendaraan),
  UNIQUE KEY uq_kendaraan_plat (plat_nomor),
  KEY idx_kendaraan_user (id_user),
  CONSTRAINT fk_kendaraan_user
    FOREIGN KEY (id_user) REFERENCES tb_user(id_user)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tb_transaksi (
  id_parkir INT(11) NOT NULL AUTO_INCREMENT,
  id_kendaraan INT(11) NOT NULL,
  waktu_masuk DATETIME NOT NULL,
  waktu_keluar DATETIME DEFAULT NULL,
  id_tarif INT(11) NOT NULL,
  durasi_jam INT(5) DEFAULT NULL,
  biaya_total DECIMAL(10,0) NOT NULL DEFAULT 0,
  status ENUM('masuk','keluar') NOT NULL DEFAULT 'masuk',
  id_user INT(11) NOT NULL,
  id_area INT(11) NOT NULL,
  PRIMARY KEY (id_parkir),
  KEY idx_transaksi_waktu (waktu_masuk),
  KEY idx_transaksi_status (status),
  KEY idx_transaksi_kendaraan_status (id_kendaraan,status),
  CONSTRAINT fk_transaksi_kendaraan
    FOREIGN KEY (id_kendaraan) REFERENCES tb_kendaraan(id_kendaraan)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_transaksi_tarif
    FOREIGN KEY (id_tarif) REFERENCES tb_tarif(id_tarif)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_transaksi_user
    FOREIGN KEY (id_user) REFERENCES tb_user(id_user)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_transaksi_area
    FOREIGN KEY (id_area) REFERENCES tb_area_parkir(id_area)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tb_log_aktivitas (
  id_log INT(11) NOT NULL AUTO_INCREMENT,
  id_user INT(11) NOT NULL,
  aktivitas VARCHAR(100) NOT NULL,
  waktu_aktivitas DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_log),
  KEY idx_log_waktu (waktu_aktivitas),
  CONSTRAINT fk_log_user
    FOREIGN KEY (id_user) REFERENCES tb_user(id_user)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- DATA USER CONTOH

INSERT INTO tb_user
(nama_lengkap, username, password, role, status_aktif)
SELECT 'Alea Kennedy', 'alea', 'alea', 'admin', 1
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE username='alea');

INSERT INTO tb_user
(nama_lengkap, username, password, role, status_aktif)
SELECT 'Baskara Santoso', 'baskara', 'baskara', 'petugas', 1
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE username='baskara');

INSERT INTO tb_user
(nama_lengkap, username, password, role, status_aktif)
SELECT 'Camila Putri', 'camila', 'camila', 'owner', 1
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE username='camila');

INSERT INTO tb_user
(nama_lengkap, username, password, role, status_aktif)
SELECT 'Dayat Jojo', 'dayat', 'dayat', 'petugas', 1
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE username='dayat');

INSERT INTO tb_user
(nama_lengkap, username, password, role, status_aktif)
SELECT 'Emily Yorr', 'emily', 'emily', 'petugas', 1
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE username='emily');

INSERT INTO tb_user
(nama_lengkap, username, password, role, status_aktif)
SELECT 'Fawas Hidayat', 'fawas', 'fawas', 'petugas', 1
WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE username='fawas');

-- DATA TARIF

INSERT INTO tb_tarif (jenis_kendaraan, tarif_per_jam)
SELECT 'motor', 3000
WHERE NOT EXISTS (SELECT 1 FROM tb_tarif WHERE jenis_kendaraan='motor');

INSERT INTO tb_tarif (jenis_kendaraan, tarif_per_jam)
SELECT 'mobil', 5000
WHERE NOT EXISTS (SELECT 1 FROM tb_tarif WHERE jenis_kendaraan='mobil');

INSERT INTO tb_tarif (jenis_kendaraan, tarif_per_jam)
SELECT 'lainnya', 7000
WHERE NOT EXISTS (SELECT 1 FROM tb_tarif WHERE jenis_kendaraan='lainnya');

-- DATA AREA PARKIR

INSERT INTO tb_area_parkir (nama_area, kapasitas, terisi)
SELECT 'Lobby Hotel', 20, 0
WHERE NOT EXISTS (SELECT 1 FROM tb_area_parkir WHERE nama_area='Lobby Hotel');

INSERT INTO tb_area_parkir (nama_area, kapasitas, terisi)
SELECT 'Basement', 40, 0
WHERE NOT EXISTS (SELECT 1 FROM tb_area_parkir WHERE nama_area='Basement');

INSERT INTO tb_area_parkir (nama_area, kapasitas, terisi)
SELECT 'Area Karyawan', 15, 0
WHERE NOT EXISTS (SELECT 1 FROM tb_area_parkir WHERE nama_area='Area Karyawan');
