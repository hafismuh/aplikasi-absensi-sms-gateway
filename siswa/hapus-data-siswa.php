<?php
	include '../lib/koneksi.php';
	$NIS = $_GET['NIS'];


	$sql = "DELETE FROM tb_siswa WHERE NIS = '$NIS'";
	$result = mysqli_query($conn, $sql);
	if ($result) {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Berhasil di Hapus'); 
				window.location.href='data-siswa.php';
			  </script>"; 
	} else {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Gagal di Hapus'); 
				window.location.href='data-siswa.php';
			  </script>"; 
	}
?>
