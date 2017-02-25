<?php
	include '../lib/koneksi.php';
	$NIS = htmlentities(trim($_POST['NIS']));
	$NamaSiswa = htmlentities(trim($_POST['NamaSiswa']));
	$JenisKelamin = htmlentities(trim($_POST['JenisKelamin']));
	$TempatLahir = htmlentities(trim($_POST['TempatLahir']));
	$TanggalLahir = htmlentities(trim($_POST['TanggalLahir']));
	$Agama = htmlentities(trim($_POST['Agama']));
	$AlamatSiswa = htmlentities(trim($_POST['AlamatSiswa']));
	$KodeKls = htmlentities(trim($_POST['KodeKls']));


	$sql = ("INSERT INTO tb_siswa (NIS, NamaSiswa, JenisKelamin, TempatLahir, TanggalLahir, 
		Agama, NoTelp, AlamatSiswa, KodeKls)VALUES ('$NIS', '$NamaSiswa', '$JenisKelamin', '$TempatLahir', '$TanggalLahir', '$Agama', '$NoTelp', '$AlamatSiswa', '$KodeKls')") or die(mysql_error());
	$result = mysqli_query($conn, $sql);

	header("location: data-siswa.php");
?>