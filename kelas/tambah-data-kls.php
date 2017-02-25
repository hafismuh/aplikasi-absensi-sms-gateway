<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
  ?>

<?php
  include '../lib/koneksi.php';
?>
<!DOCTYPE html>
<html lang="en">
<?php
// include '../header.php';
?>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Aplikasi Absensi SMS Gateway</title>

    <!-- Bootstrap -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
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
      <div class="input-group">
      <legend>Entri Data Kelas</legend>
        <form method="POST" action="simpan-data-kls.php">
          <div class="form-group">
            <div class="input-group">
            <label>Kode Kelas</label>
            <input type="text" name="KodeKls" class="form-control" id="KodeKls" required>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
            <label>Nama Kelas</label>
            <input type="text" name="NamaKls" class="form-control" id="NamaKls" required>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
            <label>Pilih Jurusan</label>
            <select name="KodeJrs" class="form-control">
            <option value="" selected="selected">Jurusan</option>
                <?php
                  include '../lib/koneksi.php';
                  $sql = "SELECT * FROM tb_jurusan";
                  $result = mysqli_query($conn, $sql);
                  while($data=mysqli_fetch_array($result)){
                    echo "<option value=$data[KodeJrs]>$data[NamaJrs]</option>";
                  }
                ?>
            </select>
            </div>
          </div>
        <input type="submit" class="btn btn-info" name="submit" value="Simpan"></input>
        <input type="submit" class="btn btn-info" name="submit" value="Batal"></input>
      </form>
      </div>
    </div>
  </div>

  <?php
      include '../footer.php';
  ?>
  
    <script src="../assets/js/jquery.js"></script>  
    <script src="../assets/js/bootstrap.min.js"></script>
  </body>
</html>

<?php
}
else
{
 header("location:../login.php");
}
?>