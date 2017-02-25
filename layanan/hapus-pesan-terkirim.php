<?php
	include '../lib/koneksi.php';
	$ID = $_GET['ID'];


	$sql = "DELETE FROM sentitems WHERE ID = '$ID'";
	$result = mysqli_query($conn, $sql);
	header("location: pesan-terkirim.php");
?>
