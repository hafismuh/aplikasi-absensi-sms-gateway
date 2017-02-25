<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
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
  include "../menu.php";
?>
  <div class="container">
  <div class="row">
  <legend>Manajemen Data Jurusan</legend>
  <p><a href="../jurusan/tambah-data-jrs.php"><button type="button" class="btn btn-primary">Tambah Data</button></a></p>
    <table class="table table-condensed table-bordered" id="table">
      <thead>
      <tr>
        <th width='5'>No.</th>
        <th>Kode Jurusan</th>
        <th>Nama Jurusan</th>
        <th align="center">Aksi</th>
      </tr>
      </thead>
    <tbody>
    
    <?php
        include '../lib/koneksi.php';
        $sql = "SELECT * FROM tb_jurusan";
        $result = mysqli_query($conn, $sql);
        $i = 1;
        $rows = mysqli_num_rows($result);
        if ($rows == 0) {
          echo "<td colspan='4'>Data kosong. Silakan tambah data!</td>";
        } else {
          $No = 1;
          while ($data = mysqli_fetch_array($result)) {
            ?>

        <tr>
        <td><?php echo $No; ?></td>
        <td><?php echo $data['KodeJrs']; ?></td>
        <td><?php echo $data['NamaJrs']; ?></td>
        <td align="center">
        <a href="ubah-data-jrs.php?KodeJrs=<?php echo $data['KodeJrs'];?>">
        <span class="glyphicon glyphicon-edit" aria-hidden="true" title="Ubah"></span>
        </a>                
        ||
        <a href="hapus-data-jrs.php?KodeJrs=<?php echo $data['KodeJrs'];?>">
        <span class="glyphicon glyphicon-trash" aria-hidden="true" title="Hapus"></span>
        </a>
        </td>
        </tr>

    <?php  
        $No++;
        }
      }
    ?>

    </tbody>
    </table>
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
