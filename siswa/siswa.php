<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
  ?>
<!DOCTYPE html>
<html lang="en">
<?php
//include '../header.php';
?>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Aplikasi Absensi SMS Gateway</title>

    <!-- Bootstrap -->
    <link href="../assets/css/bootstrap1.min.css" rel="stylesheet">
    <link href="../assets/css/sticky-footer-navbar.css" rel="stylesheet">
    <link href="../assets/css/navbar-static-top.css" rel="stylesheet">
  </head>
  <body>

<?php
  include "../menu.php";
  $KodeKls = isset($_POST['KodeKls'])? $_POST['KodeKls'] : '';
?>
  
  <div class="container">
  <div class="row">
  <div class="col-lg-12">
  <img src="../assets/img/logo-diknas2.png" align="left">
  <img src="../assets/img/logo-smk2.png" align="right">
  <div style="border-bottom:solid 2px" id="container">
  <div class="row">
  <h2 align="center"><b>SMK TEKNOLOGI PLUS PADANG</h2></b>
  <p align="center">
  Jl. Belanti Indah No. 5 Khatib Sulaiman, Padang</br>
  Telp. (0751) 7051030, Fax (0751) 446907</br>
  Email : teknologipluspadang@ymail.com</p>
  </div>
  </div>

  <div id="container">
  <div class="row">
  <div class="col-lg-12">
  <p></p>
  <h4 align="center"><b>REKAPITULASI ABSENSI SISWA</b></h4>
   <form action="" method="POST" class="hidden-print">
  <div class="form-group hidden-print">
  <div class="input-group col-md-2">
  <label>Pilih Kelas</label>
  <select name="KodeKls" class="form-control" onchange="this.form>submit();">
  <option value="" selected="selected">Kelas</option>
  <?php
    include '../lib/koneksi.php';
    $sql = "SELECT * FROM tb_kelas";
    $result = mysqli_query($conn, $sql);
    while($data=mysqli_fetch_array($result))
    {
      echo "<option value=$data[KodeKls]>$data[NamaKls]</option>";
    }
  ?>
  </select>
  </div>
  </div>
  </form>
  </div>
  </div>
  </div>

  <table class="table table-bordered" table-condensed id="export" align="center">
  <thead>
    <tr>
      <th>No.</th>
      <th>NIS</th>
      <th>Nama</th>
      <th>Jenis Kelamin</th>
      <th>Tempat Lahir</th>
      <th>Tanggal Lahir</th>
      <th>Agama</th>
      <th>Alamat</th>    
      <th align="center">Aksi</th>
    </tr>
   </thead>
  <tbody>

  <?php
  include '../lib/koneksi.php';
  if(isset($_POST['KodeKls']))
  {     

    $myquery="select tb_siswa.NIS, tb_siswa.NamaSiswa, tb_siswa.JenisKelamin, tb_siswa.TempatLahir, tb_siswa.TanggalLahir,
              tb_siswa.Agama, tb_siswa.AlamatSiswa from tb_siswa, tb_kelas where tb_siswa.KodeKls=tb_kelas.KodeKls AND tb_siswa.KodeKls=$KodeKls";
  }
  else
  {
    $myquery="select * from tb_siswa";
  } 
  $daftarsiswa=mysqli_query($conn, $myquery) or die (mysql_error());
  $i = 1;
  $rows = mysqli_num_rows($daftarsiswa);
  if ($rows == 0) {
    
  } else {
    $No = 1;
    while($dataku=mysqli_fetch_object($daftarsiswa))
  {
  ?>
        <tr>
        <td><?php echo $No; ?></td>
        <td><?php echo  $dataku->NIS?></td>
        <td><?php echo  $dataku->NamaSiswa?></td>
        <td><?php echo  $dataku->JenisKelamin?></td>
        <td><?php echo  $dataku->TempatLahir?></td>
        <td><?php echo  $dataku->TempatLahir?></td>
        <td><?php echo  $dataku->Agama?></td>
        <td><?php echo  $dataku->AlamatSiswa?></td>
        </tr>
  <?php  
        $No++;
        }
      }
    ?>
  </tbody>
  </table>

    <div class="col-md-3 pull-left" align="center">
    <p>Diketahui oleh:
    <br>Kepala Sekolah,</p>
    <p>  <br> </p>
    <p><u> Ir. Hj. Allismawita, MS</u><br>
    19550426.198003.2.001</p>
   
    </div>

    <div class="col-md-3 pull-right" align="center">
    <p>Padang, <?php $tgl=date('d M Y'); echo $tgl; ?>
    <br>Koordinator Absensi,</p>
    <p>  <br> </p>
    <p><u> Ari Limay Trisno, S.Pd</u><br>
    101.200.0.190</p>
    </div>

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