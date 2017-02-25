<?php
	include '../lib/koneksi.php';
	$NamaPtg = htmlentities(trim($_POST['NamaPtg']));
	$NamaPgn = htmlentities(trim($_POST['NamaPgn']));
	$Sandi = htmlentities(trim($_POST['Sandi']));

	$sql = ("INSERT INTO tb_petugas VALUES ('$NamaPtg', '$NamaPgn', md5('$Sandi'))") or die(mysql_error());
	$result = mysqli_query($conn, $sql);

	header("location: data-petugas.php");
?>