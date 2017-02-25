<?php
header("Content-type: application/vnd-ms-excel");
header("Content-Disposition: attachment; filename=Rekap Absensi.xls");
?>
<table class="table table-bordered" id="export">
      <thead>
      <tr>
        <th>NIS</th>
        <th>Nama</th>
        <th>H</th>
        <th>A</th>
        <th>I</th>
        <th>S</th>
      </tr>
      </thead>
    <tbody>

    <?php
  include '../lib/koneksi.php';
  if(isset($txtcari))
  {
    $myquery="select NIS, NamaSiswa from tb_siswa where NIS='$txtcari' or NamaSiswa LIKE '%$txtcari%'";
  }
  else
  {
    $myquery="select NIS, NamaSiswa from tb_siswa";
  } 
  $daftarsiswa=mysqli_query($conn, $myquery) or die (mysql_error());
  while($dataku=mysqli_fetch_object($daftarsiswa))
  {
  ?>
        <tr>
        <td><?php echo  $dataku->NIS?></td>
        <td><?php echo  $dataku->NamaSiswa?></td>
        <td>
          <?php
            $sql = "SELECT COUNT(KetAbsen) AS KetAbsen FROM tb_absen WHERE NIS=$dataku->NIS AND KetAbsen='Hadir'";
            $query = mysqli_query($conn, $sql);
            $result = mysqli_fetch_object($query);
            echo $result->KetAbsen;
          ?>
        </td>
        <td>
          <?php
            $sql = "SELECT COUNT(KetAbsen) AS KetAbsen FROM tb_absen WHERE NIS=$dataku->NIS AND KetAbsen='Alpa'";
            $query = mysqli_query($conn, $sql);
            $result = mysqli_fetch_object($query);
            echo $result->KetAbsen;
          ?>
        </td>
        <td>
          <?php
            $sql = "SELECT COUNT(KetAbsen) AS KetAbsen FROM tb_absen WHERE NIS=$dataku->NIS AND KetAbsen='Izin'";
            $query = mysqli_query($conn, $sql);
            $result = mysqli_fetch_object($query);
            echo $result->KetAbsen;
          ?>
        </td>
        <td>
          <?php
            $sql = "SELECT COUNT(KetAbsen) AS KetAbsen FROM tb_absen WHERE NIS=$dataku->NIS AND KetAbsen='Sakit'";
            $query = mysqli_query($conn, $sql);
            $result = mysqli_fetch_object($query);
            echo $result->KetAbsen;
          ?>
        </td>
        </tr>
  <?php
  }
  ?>
    </tbody>
    </table>