<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
  ?>

<?php
  include "../lib/koneksi.php";
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
      <div class="input-group">
      <legend>Entri Data Siswa</legend>
        <form method="POST" action="simpan-data-siswa.php">
          <div class="form-group">
            <div class="input-group">
            <label>NIS</label>
            <input type="text" name="NIS" class="form-control" id="NIS" required></input>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
            <label>Nama Siswa</label>
            <input type="text" name="NamaSiswa" class="form-control" id="NamaSiswa" required></input>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
            <label>Pilih Jenis Kelamin</label>
            <select name="JenisKelamin" class="form-control">
            <option selected="selected">Jenis Kelamin</option>
            <option value="Laki-Laki">Laki-Laki</option>
            <option value="Perempuan">Perempuan</option>
            </select>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
            <label>Tempat Lahir</label>
            <textarea name="TempatLahir" class="form-control" required></textarea>
            </div>
          </div>
          <div class="form-group">
            <label>Tanggal Lahir</label>
              <div class="input-group date form_date" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
              <input class="form-control" type="text" disabled="disabled">
              <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
              <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
              </div>
            <input type="hidden" id="dtp_input2" name="TanggalLahir" value="1995-08-05">
          </div>
          <div class="form-group">
            <div class="input-group">
            <label>Pilih Agama</label>
            <select name="Agama" class="form-control">
            <option value="" selected="selected">Agama</option>
            <option value="Islam">Islam</option>
            <option value="Katolik">Katolik</option>
            <option value="Protestan">Protestan</option>
            <option value="Hindu">Hindu</option>
            <option value="Buddha">Buddha</option>           
            </select>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
            <label>Alamat</label>
            <textarea name="AlamatSiswa" class="form-control" required></textarea>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
            <label>Pilih Kelas</label>
            <select name="KodeKls" class="form-control">
            <option value="" selected="selected">Kelas</option>
                <?php
                  include '../lib/koneksi.php';
                  $sql = "SELECT * FROM tb_kelas";
                  $result = mysqli_query($conn, $sql);
                  while($data=mysqli_fetch_array($result)){
                    echo "<option value=$data[KodeKls]>$data[NamaKls]</option>";
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