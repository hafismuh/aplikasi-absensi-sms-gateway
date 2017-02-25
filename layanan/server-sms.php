<!DOCTYPE html>
<head>
<title>Server SMS</title>
<!-- refresh script setiap 30 detik --> 
<meta http-equiv="refresh" content="10; url=<?php $_SERVER['PHP_SELF']; ?>">
</head>
<body>
	<h1>Server SMS sedang berjalan...</h1>
   <p>*Halaman ini harus terbuka untuk memuat data SMS.</p> 
	<?php
	//error_reporting(0);
	include '../lib/koneksi.php';
	// $conn=open_connection();
	$absenceknis = 1;
	$laporanceknis = 1;
	// query untuk membaca SMS yang belum diproses
	$query = "SELECT * FROM inbox WHERE Processed = 'false'";
	$hasil = mysqli_query($conn, $query);
	while ($data = mysqli_fetch_array($hasil))
	{
		// membaca ID SMS
		$id = $data['ID'];   // membaca no pengirim
		$noPengirim = $data['SenderNumber'];   // membaca pesan SMS dan mengubahnya menjadi kapital
		$msg = strtoupper($data['TextDecoded']);   // proses parsing    // memecah pesan berdasarkan karakter <spasi> 
		$pecah = explode(" ", $msg);  // baca NIS dari pesan SMS
		$nis = $pecah[2];   // jika kata terdepan dari SMS adalah 'CEK' dan 'ABSEN' maka cari keterangan Absensi
		if ($pecah[0] == "CEK" && $pecah[1] == "ABSEN") {
			//cari nama siswa, kelas, keterangan kehadiran pada hari ini  berdasar NIS
			//$query2 = "SELECT nilai FROM nilaikalkulus WHERE nim = '$nim'";
			$query2 = "SELECT NamaSiswa, NamaKls, KetAbsen, TglAbsen from tb_siswa INNER JOIN tb_absen ON tb_siswa.NIS = tb_absen.NIS INNER JOIN tb_kelas ON tb_siswa.KodeKls = tb_kelas.KodeKls WHERE tb_absen.NIS = '$nis' AND TglAbsen = CURDATE()";      
         	$hasil2 = mysqli_query($conn, $query2); 
            // cek bila data Absensi tidak ditemukan

             if (mysqli_num_rows($hasil2) == 0) {
               $reply = "Data Siswa tidak ditemukan, Cek Kembali NIS";
               $absenceknis = 0;

            } else {
             // bila nilai ditemukan
               $data2 = mysqli_fetch_array($hasil2);
               $nama_siswa = $data2['NamaSiswa'];
               $nama_kelas = $data2['NamaKls'];
               $keterangan = $data2['KetAbsen'];
               $tanggal = $data2['TglAbsen'];
               $reply = $tanggal." Nama: ".$nama_siswa.". Kelas: ".$nama_kelas.". Keterangan: ".$keterangan;
             }
      }
                // FORMAT SMS KE2
      else if ($pecah[0] == "CEK" && $pecah[1] == "LAPORAN") {

          // baca NIS dari pesan SMS
          //$nis = $pecah[2];
          // cari nilai kalkulus berdasar NIM
            $query9 = "SELECT NamaSiswa, NamaKls from tb_siswa INNER JOIN tb_kelas ON tb_siswa.KodeKls = tb_kelas.KodeKls WHERE tb_siswa.NIS = '$nis'";
            $hasil9 = mysqli_query($conn, $query9);
            // cek bila data nilai tidak ditemukan
            if (mysqli_num_rows($hasil9) == 0) {
               $reply = "Data Siswa tidak ditemukan, Cek Kembali NIS";
               $laporanceknis = 0;
            } else {
            //Hitung Bulanan
               $awalbulan = date('Y-m-1');
               $sekarang = date('Y-m-d');
               //Hitung Jumlah Masuk
               $QHadir = "SELECT COUNT( KetAbsen ) AS 'jumlahabsen' FROM tb_siswa INNER JOIN tb_absen ON tb_siswa.NIS = tb_absen.NIS WHERE tb_absen.KetAbsen = 'Hadir' AND tb_siswa.NIS =
               $nis AND (TglAbsen between '$awalbulan' AND '$sekarang') ";
               $jumlahhadir = mysqli_query( $conn, $QHadir ) or die(mysqli_error()."error 1");
               $datahadir = mysqli_fetch_array($jumlahhadir);
               $totalhadir = $datahadir[0];
               //Hitung Jumlah Alpa
               $QAlpa = "SELECT COUNT( KetAbsen ) AS 'jumlahabsen' FROM tb_siswa INNER JOIN tb_absen ON tb_siswa.NIS = tb_absen.NIS WHERE tb_absen.KetAbsen = 'Alpa' AND tb_siswa.NIS = $nis
               AND (TglAbsen between '$awalbulan' AND '$sekarang') ";
               $jumlahalpa = mysqli_query( $conn, $QAlpa ) or die(mysqli_error()."error 4");
               $dataalpa = mysqli_fetch_array($jumlahalpa);
               $totalalpa = $dataalpa[0];               
               //Hitung Jumlah Izin
               $QIzin = "SELECT COUNT( KetAbsen ) AS 'jumlahabsen' FROM tb_siswa INNER JOIN tb_absen ON tb_siswa.NIS = tb_absen.NIS WHERE tb_absen.KetAbsen = 'Izin' AND tb_siswa.NIS = $nis
               AND (TglAbsen between '$awalbulan' AND '$sekarang') ";
               $jumlahizin = mysqli_query( $conn, $QIzin ) or die(mysqli_error())."error 3";
               $dataizin = mysqli_fetch_array($jumlahizin);
               $totalizin = $dataizin[0];   
               //Hitung Jumlah Sakit
               $QSakit = "SELECT COUNT( KetAbsen ) AS 'jumlahsakit' FROM tb_siswa INNER JOIN tb_absen ON tb_siswa.NIS = tb_absen.NIS WHERE tb_absen.KetAbsen = 'Sakit' AND tb_siswa.NIS = $nis             
               AND (TglAbsen between '$awalbulan' AND '$sekarang') ";
               $jumlahsakit = mysqli_query( $conn, $QSakit ) or die(mysqli_error()."error 2");
               $datasakit = mysqli_fetch_array($jumlahsakit);
               $totalsakit = $datasakit[0];            
               //isi balasan
               $data9 = mysqli_fetch_array($hasil9);
               $nama_siswa = $data9['NamaSiswa'];
               $nama_kelas = $data9['NamaKls'];
               $reply = "Statistik Kehadiran ".$nama_siswa." Kelas: ".$nama_kelas." bulan ini: Masuk: ".$totalhadir.". Sakit: ".$totalsakit.". Izin: ".$totalizin.". Alpa: ".$totalalpa;
            }
         } 
      else 
         {
               $reply = "Maaf format SMS Anda salah. Ketik CEK (spasi) ABSEN (spasi) NIS atau CEK (spasi) LAPORAN (spasi) NIS";              
         }
            $query = "INSERT INTO outbox(DestinationNumber, TextDecoded) VALUES ('$noPengirim', '$reply')";
            $query = mysqli_query($conn, $query);
            $query = "UPDATE inbox SET Processed = 'true' WHERE ID = '$id'";
            $query = mysqli_query($conn, $query);
      }
?>
</body>
</html>       	