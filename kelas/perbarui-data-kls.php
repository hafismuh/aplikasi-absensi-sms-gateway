<?php
	include "../lib/koneksi.php";
	$KodeKls = htmlentities(trim($_POST['KodeKls']));
	$NamaKls = htmlentities(trim($_POST['NamaKls']));
	$KodeJrs = htmlentities(trim($_POST['KodeJrs']));


	$sql = ("UPDATE tb_kelas SET NamaKls = '$NamaKls', KodeJrs = '$KodeJrs' WHERE KodeKls = '$KodeKls'") or die(mysql_error());
	$result = mysqli_query($conn, $sql);	
	if ($result) {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Berhasil Diubah'); 
				window.location.href='data-kls.php';
			  </script>"; 
	} else {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Gagal di Edit'); 
				window.location.href='data-kls.php';
			  </script>"; 
	}
	// header("location:data-jrs.php");
?>