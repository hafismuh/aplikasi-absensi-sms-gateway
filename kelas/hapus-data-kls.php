<?php
	include '../lib/koneksi.php';
	$KodeKls = $_GET['KodeKls'];


	$sql = "DELETE FROM tb_kelas WHERE KodeKls = '$KodeKls'";
	$result = mysqli_query($conn, $sql);
	if ($result) {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Berhasil di Hapus'); 
				window.location.href='data-kls.php';
			  </script>"; 
	} else {
		mysqli_close($conn);
		echo "<script type='text/javascript'>
				alert('Data Gagal di Hapus'); 
				window.location.href='data-kls.php';
			  </script>"; 
	}
?>
