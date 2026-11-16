USE parkirin;

ALTER TABLE tb_user MODIFY password VARCHAR(255) NOT NULL;

-- Password plaintext lama akan diubah menjadi password_hash secara otomatis
-- saat masing-masing akun berhasil login setelah kode PARKIRIN diperbarui.
