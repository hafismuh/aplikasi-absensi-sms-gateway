<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
  ?>

<!DOCTYPE html>
<html lang="en">
<?php
// include "../header.php";
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
    <link href="../assets/font-awesome-4.6.3/css/font-awesome.css" rel="stylesheet">
    <link href="../assets/css/dataTables.bootstrap.min.css" rel="stylesheet">
  </head>
  <body>
<?php
  include "../menu.php";
?>
  <div class="container">
  <div class="row">
  <legend>Pesan Keluar</legend>
    <table class="table table-condensed table-bordered" id="table">
      <thead>
      <tr>
        <th>No.</th>
        <th>Penerima</th>
        <th>Pesan</th>
        <th>Terkirim</th>
        <th>Diterima</th>
        <th>Status</th>
        <th>Aksi</th>
      </tr>
      </thead>
    <tbody>
    <?php
        include '../lib/koneksi.php';
        $sql = "SELECT * FROM sentitems";
        $result = mysqli_query($conn, $sql);
        while($data = mysqli_fetch_array($result))
        {
            ?>
        <tr>
        <td><?php echo $data['ID']; ?></td>
        <td><?php echo $data['DestinationNumber']; ?></td>
        <td><?php echo $data['TextDecoded']; ?></td>
        <td><?php echo $data['SendingDateTime']; ?></td>
        <td><?php echo $data['UpdatedInDB']; ?></td>
        <td><?php echo $data['Status']; ?></td>
        <td>
          <a href="hapus-pesan-terkirim.php?ID=<?php echo $data['ID'];?>">
          <span class="glyphicon glyphicon-trash" aria-hidden="true" title="Hapus"></span>
        </a>
        </td>
        </tr>

    <?php  
        }
    ?>

    </tbody>
    </table>
  </div>
  </div>
    <script src="../assets/js/jquery.js"></script>  
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/jquery.dataTables.min.js"></script>
    <script src="../assets/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript">
      $(function() {
        $("#table").DataTable();
      });

    </script>
  </body>
  <?php
  include "../footer.php";
  ?>
</html>
<?php
}
else
{
 header("location:../login.php");
}
?>