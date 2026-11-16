<?php
    
class Koneksi
{
    private $host     = "sql211.infinityfree.com";
    private $username = "if0_432211245";
    private $password = "AnggaParkir";
    private $db       = "if0_432211245_parkirin";

    public $koneksi; 

    public function __construct()
    {
       
        $this->koneksi = mysqli_connect($this->host, $this->username, $this->password, $this->db);

        if (!$this->koneksi) {
            
            die("Koneksi database gagal: " . mysqli_connect_error());
        }
        mysqli_set_charset($this->koneksi, "utf8mb4");
    }
}
