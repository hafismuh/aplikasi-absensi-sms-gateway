<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
?>
<!DOCTYPE html>
<html lang="en">
<?php
  include '../lib/koneksi.php';
// include '../header.php';
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
  <p></p>
  <h4 align="center"><b>DETAIL ABSENSI SISWA</b></h4>
  <div class="col-lg-3">
  <?php
    $txtcari = isset($_GET['txtcari'])? $_GET['txtcari'] : '0';
  ?>
  <form action="" method="get" name="FCari" id="FCari" class="hidden-print">
  <div class="input-group">
    <input name="txtcari" type="text" class="form-control" placeholder="Masukkan NIS atau Nama" value="<?php echo $txtcari?>">
    <span class="input-group-btn">
      <button class="btn btn-primary" type="submit" value="Cari">Cari!</button>
    </span>
  </div><!-- /input-group -->  
  </form>
  
  <?php
    $sql="SELECT * FROM tb_siswa, tb_kelas, tb_jurusan WHERE NIS=$txtcari";
    $result=mysqli_query($conn, $sql);
    $dataku=mysqli_fetch_array($result);
  ?>
  </div>

  <?php
    if(isset($_GET['txtcari'])){
  ?>

  <div class="col-md-2 pull-right hidden-print">
  <button onclick="window.print();" class="btn btn-primary hidden-print ">Print</button>
  <a href="detail-absensi-export.php"> <button class="btn btn-success">Export</button></a>
  </div>
  </div><p>
  </div>
  </div>

  <table class="table table-bordered table-condensed" align="center">
  <thead>
      <tr>
        <td rowspan="4" align='center' width='20'><img src="../assets/img/noprofile.gif" width="60" height="100" align="center"></td>
        <th width='20'>NIS</td><td width='30'><?php echo $dataku['NIS'] ?></th>        
      </tr>
      <tr>
        <th width='20'>Nama</td><td width='50'><?php echo $dataku['NamaSiswa'] ?></th>
      </tr>
        <tr>
        <th width='20'>Kelas</td><td width='30'><?php echo $dataku['NamaKls'] ?></th>        
      </tr>
      <tr>
        <th width='20'>Jurusan</td><td width='50'><?php echo $dataku['NamaJrs'] ?></th>
      </tr>
  </thead>
  </table>

    <table class="table table-bordered table-condensed" align="center" width="730">
      <thead>
      <tr>
        <th>No.</th>
        <th>Tanggal</th>
        <th>Keterangan</th>
      </tr>
      </thead>
    <tbody>
 <?php
 $nomor=1;
  $myquery="SELECT tb_absen.TglAbsen, tb_absen.KetAbsen FROM tb_siswa, tb_absen WHERE tb_siswa.NIS=tb_absen.NIS AND tb_absen.NIS=$txtcari";
  $daftarsiswa=mysqli_query($conn, $myquery) or die (mysql_error());
  while($dataku=mysqli_fetch_array($daftarsiswa))
  {
    echo "
      <tr>
        <td>$nomor</td>
        <td>$dataku[TglAbsen]</td>        
        <td>$dataku[KetAbsen]</td>        
       </tr>
    ";
    $nomor++;
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

    <?php
      }
    ?>

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