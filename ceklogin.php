<?php
	
	include 'lib/koneksi.php';

	$username = $_POST['username'];
	$pass = md5($_POST['password']);

	$sql = ("SELECT * FROM tb_petugas WHERE NamaPgn = '$username' AND Sandi = '$pass'");
	$result = mysqli_query($conn, $sql) or die(mysql_error());
	
	if (mysqli_num_rows($result) == 1)
	{
		session_start();
		$pengguna = mysqli_fetch_array($result);
		$_SESSION['NamaPtg'] = $pengguna['NamaPtg'];
		$_SESSION['StatusLogin']= "OK";
		header("location: index.php");
	}
	else
	{
	?>
		<script>
			alert("Username atau password salah !");
			history.go(-1);
		</script>
	<?php		
	}

?>