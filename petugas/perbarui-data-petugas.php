<?php
	include '../lib/koneksi.php';
	$NamaPtg = htmlentities(trim($_POST['NamaPtg']));
	$NamaPgn = htmlentities(trim($_POST['NamaPgn']));
	$Sandi = htmlentities(trim($_POST['Sandi']));

	$sql = ("UPDATE tb_petugas SET Sandi = md5('$Sandi'), 
		NamaPtg = '$NamaPtg' WHERE NamaPgn = '$NamaPgn'") 
		or die(mysql_error());
	$result = mysqli_query($conn, $sql);	
	if ($result) {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Berhasil Diubah'); 
				window.location.href='data-petugas.php';
			  </script>"; 
	} else {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Gagal di Edit'); 
				window.location.href='data-petugas.php';
			  </script>"; 
	}
	header("location:data-petugas.php");
?>