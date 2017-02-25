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


	$sql = ("UPDATE tb_siswa SET NamaSiswa = '$NamaSiswa', JenisKelamin = '$JenisKelamin', 
		TempatLahir = '$TempatLahir', TanggalLahir = '$TanggalLahir', Agama = '$Agama', AlamatSiswa = '$AlamatSiswa', KodeKls = '$KodeKls' WHERE NIS = '$NIS'") 
		or die(mysql_error());
	$result = mysqli_query($conn, $sql);	
	if ($result) {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Berhasil Diubah'); 
				window.location.href='data-siswa.php';
			  </script>"; 
	} else {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Gagal di Edit'); 
				window.location.href='data-siswa.php';
			  </script>"; 
	}
	header("location:data-siswa.php");
?>