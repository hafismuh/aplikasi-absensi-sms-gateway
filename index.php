<?php
    include "lib/koneksi.php";
    session_start();
    $_SESSION['StatusLogin'];
    if($_SESSION['StatusLogin']=="OK")
    {
?>

<!DOCTYPE html>
<html lang="en">

<?php
// include 'header.php';
?>

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel=”icon” type=”image/png” href="assets/img/favicon.png">
    <title>Aplikasi Absensi SMS Gateway</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="assets/css/navbar-static-top.css" rel="stylesheet">
    <link href="assets/css/sticky-footer-navbar.css" rel="stylesheet">
  </head>

  <body>
  <?php
  include 'menu.php';
  ?>
    <?php
    ?>
  <div class="container well">
      <div class="blog-header">
        <h1 class="blog-title">Aplikasi Absensi SMS Gateway</h1>
        <p class="lead blog-description">Deskripsi Aplikasi:</p>
      </div>
      <div class="row">
      <div class="col-sm-12 blog-main">
        <p>Aplikasi Absensi SMS Gateway adalah aplikasi yang berguna untuk mengelola data absensi siswa menjadi suatu informasi absensi berupa pesan singkat SMS yang dapat diakses melalui perangkat seluler.</p>Untuk memperoleh informasi absensi tersebut dapat dilakukan dengan cara mengirimkan pesan dengan format yang telah disesuaikan seperti berikut:</p>
        <ul>
          <li>CEK ABSEN NIS  -> Untuk mengetahui absensi siswa per hari</li>
          <ol>Contoh : <b>CEK ABSEN 16001</b></ol></br>
          <li>CEK LAPORAN NIS -> Untuk mengetahui laporan absensi siswa per bulan</li>
          <ol>Contoh : <b>CEK LAPORAN 16001</b></ol>
        </ul>
      </div>
      </div>
    </div>

    <?php
      include 'footer.php';
    ?>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    
  </body>
</html>
<?php
    }
    else
    {
    header("location:login.php");
    }
    ?>  