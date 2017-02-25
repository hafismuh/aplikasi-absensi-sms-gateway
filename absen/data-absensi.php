<?php
session_start();
if($_SESSION['StatusLogin']=="OK")
{
  ?>

<?php
//SIMPAN ABSEN
include '../lib/koneksi.php';

if (isset($_POST['keterangan_absen'])) {
  $nis = $_POST['NIS'];
  $tgl_absen = $_POST['tgl_absen'];
  $keterangan_absen = $_POST['keterangan_absen'];

  $sql = "SELECT * FROM tb_absen WHERE NIS = $nis AND TglAbsen='$tgl_absen'";
  $query = mysqli_query($conn, $sql);
  $row = mysqli_num_rows($query);
  if($row == 0)
  {
    $sql = "INSERT INTO tb_absen (NIS, TglAbsen, KetAbsen) VALUES($nis,'$tgl_absen','$keterangan_absen')";
    mysqli_query($conn, $sql);
  }
  else
  {
    $sql = "UPDATE tb_absen SET KetAbsen='$keterangan_absen' WHERE NIS=$nis AND TglAbsen ='$tgl_absen'";
    mysqli_query($conn, $sql);
  }
}
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
    <link href="../assets/css/bootstrap.css" rel="stylesheet">
    <link href="../assets/css/navbar-static-top.css" rel="stylesheet">
  </head>
  <body> 
  <?php
    include "../menu.php";
  ?>
  <div class="container">
  <div class="row">
  <legend>Halaman Absensi</legend>
  <div class="form-group">
  <div class="input-group col-md-2">
  <form action="" method="post">
    <label> Pilih Kelas</label>
    <select name="KodeKls" class="form-control" onchange="this.form.submit();">
      <option value="">Kelas</option>
        <?php
          if(isset($_POST['KodeKls']))
          {
            $KodeKls = $_POST['KodeKls'];
          }
          else
          {
            $KodeKls = "";
          }
          $sql = "SELECT * FROM tb_kelas";
          $result = mysqli_query($conn, $sql);
          while($data=mysqli_fetch_array($result)){
            if($KodeKls == $data['KodeKls'])
              {
                $select = "selected";
              }
              else
              {
                $select = "";
              }

            echo "<option $select value=$data[KodeKls]>$data[NamaKls]</option>";
          }
        ?>
      </select>
  </div>
  </div>
  <div class="form-group">
  <div class="input-group col-md-2">
    <label>Pilih Tanggal</label>
      <?php
         $tgl = isset($_POST['tgl_absen']) ? $_POST['tgl_absen'] : date('Y-m-d');
      ?>
    <input type="date" class=" form-control dtp_input2" name="tgl_absen" value="<?php echo $tgl ?>" onchange="this.form.submit();">
  </div>          
  </div>
  </form>
  <div class="table-responsive">
  <table class="table table-bordered table-striped table-hover table-condensed">
      <thead>
      <tr>
        <th>No.</th>
        <th>NIS</th>
        <th>Nama Siswa</th>
        <th>Keterangan</th>
      </tr>
      </thead>
    <tbody>
    <?php
    if(isset($_POST['KodeKls']) || isset($_POST['tgl_absen']) )
    {
        $kodeKelas = $_POST['KodeKls'];
       
        include '../lib/koneksi.php';
        $sql = "SELECT tb_siswa.NIS, tb_siswa.NamaSiswa, (SELECT KetAbsen FROM tb_absen WHERE tb_siswa.NIS = tb_absen.NIS AND TglAbsen = '$tgl') AS ket_absen FROM tb_siswa, tb_kelas WHERE tb_siswa.KodeKls = tb_kelas.KodeKls AND tb_kelas.KodeKls = $kodeKelas ";
        $result = mysqli_query($conn, $sql);
        $i = 1;
        $rows = mysqli_num_rows($result);
        if ($rows == 0) {
          echo "<td colspan='5'>Data kosong. Silakan tambah data!</td>";
        } else {
          $No = 1;
          while ($data = mysqli_fetch_array($result)) {
    ?>
        <tr>
        <td><?php echo $No; ?></td>
        <td><?php echo $data['NIS']; ?></td>
        <td><?php echo $data['NamaSiswa']; ?></td>
        <td>
          <form action="" method="POST">
            <input type="hidden" name="KodeKls" value="<?php echo $_POST['KodeKls']; ?>">
            <input type="hidden" name="NIS" value="<?php echo $data['NIS']; ?>">
            <input type="hidden" name="tgl_absen" value="<?php echo $tgl; ?>">
            <select name="keterangan_absen" class="form-control" onchange="this.form.submit();">
              <option value="">Pilih</option>
              <option  <?php if($data['ket_absen'] == "Hadir") echo "selected"?> value="Hadir">Hadir</option>
              <option  <?php if($data['ket_absen'] == "Alpa") echo "selected"?>  value="Alpa">Alpa</option>
              <option  <?php if($data['ket_absen'] == "Izin") echo "selected"?>  value="Izin">Izin</option>
              <option  <?php if($data['ket_absen'] == "Sakit") echo "selected"?>  value="Sakit">Sakit</option>
            </select>
          </form>
        </td>
        </tr>
        <?php  
          $No++;
          }
        }
        }
      ?>
      </tbody>
      </table>
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
