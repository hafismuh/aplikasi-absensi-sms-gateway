<?php
	require_once '../lib/koneksi.php';
	$KodeKls = htmlentities(trim($_POST['KodeKls']));
	$NamaKls = htmlentities(trim($_POST['NamaKls']));
	$KodeJrs = htmlentities(trim($_POST['KodeJrs']));


	$sql = ("INSERT INTO tb_kelas (KodeKls, NamaKls, KodeJrs)
			VALUES ('$KodeKls', '$NamaKls', '$KodeJrs')
			") or die(mysql_error());
	$result = mysqli_query($conn, $sql);

	header("location: data-kls.php");
?>