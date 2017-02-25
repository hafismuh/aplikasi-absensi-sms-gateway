<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
  ?>

<?php
    include "../lib/koneksi.php";

    $KodeKls = htmlentities($_GET['KodeKls']);
    $sql = "SELECT * FROM tb_kelas WHERE KodeKls = '$KodeKls'";
    $result = mysqli_query($conn, $sql);
    $data2 = mysqli_fetch_array($result);
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
      <legend>Ubah Data Kelas</legend>
        <form method="POST" action="perbarui-data-kls.php">
          <div class="form-group">
            <div class="input-group col-md-5">
            <label>Kode Kelas</label>
            <input type="text" name="KodeKls" value="<?php echo $data2['KodeKls']; ?>" readonly class="form-control" id="KodeKls">
            </div>
          </div>
          <div class="form-group">
            <div class="input-group col-md-5">
            <label>Nama Kelas</label>
            <input type="text" name="NamaKls" value="<?php echo $data2['NamaKls']; ?>" class="form-control" id="NamaKls" required>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group col-md-5">
            <label>Jurusan</label>
            <select name="KodeJrs" class="form-control">
            <option value="" selected="selected">Pilih Jurusan</option>
                <?php
                  include '../lib/koneksi.php';
                  $query = "SELECT * FROM tb_jurusan";
                  $hasil = mysqli_query($conn, $query);
                  while($data=mysqli_fetch_array($hasil)){
                    echo "<option value=$data[KodeJrs]>$data[NamaJrs]</option>";
                  }
                ?>
            </select>
            </div>
          </div>
        <input type="submit" class="btn btn-info" name="submit" value="Perbarui"></input>
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