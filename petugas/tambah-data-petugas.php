<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
  ?>

<?php
  // include "../lib/koneksi.php";
?>
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Aplikasi Absensi SMS Gateway</title>

    <!-- Bootstrap -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
    <link href="../assets/css/sticky-footer-navbar.css" rel="stylesheet">
    <link href="../assets/css/navbar-static-top.css" rel="stylesheet">
  </head>
  <body>
  <?php
    include '../menu.php';
  ?>
  <div class="container">
    <div class="row">
      <div class="span12">
      <legend>Tambah Data Petugas</legend>
        <form method="POST" action="simpan-data-petugas.php">        
           <div class="form-group">
            <div class="input-group col-md-3">
            <label>Nama Petugas</label>
            <input type="text" name="NamaPtg" class="form-control" id="NamaPtg" required></input>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group col-md-2">
            <label>Nama Pengguna</label>
            <input type="text" name="NamaPgn" class="form-control" id="NamaPgn" required></input>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group col-md-2">
            <label>Sandi</label>
            <input type="password" name="Sandi" class="form-control" id="Sandi" required></input>
            </div>
          </div>
        <input type="submit" class="btn btn-info" name="submit" value="Simpan"></input><br>
      </form><br>
      </div>
    </div>
  </div>

  <?php
      include '../footer.php';
  ?>
  
    <script src="../assets/js/jquery.js"></script>  
    <script src="../assets/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../assets/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="../assets/js/bootstrap-datetimepicker.id.js"></script>
    <script type="text/javascript">
      $('.form_date').datetimepicker({
          language:  'id',
          weekStart: 1,
          todayBtn:  1,
      autoclose: 1,
      todayHighlight: 1,
      startView: 2,
      minView: 2,
      forceParse: 0
      });
    </script>
  </body>
</html>

<?php
}
else
{
 header("location:../login.php");
}
?>