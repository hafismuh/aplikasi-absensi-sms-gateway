<?php
header("Content-type: application/vnd-ms-excel");
header("Content-Disposition: attachment; filename=Detail Absensi.xls");
?>

  <div class="container">
  <div class="row">
  <div class="col-lg-3">
  <?php
    $txtcari = isset($_GET['txtcari'])? $_GET['txtcari'] : '0';
  ?>
  <form action="" method="get" name="FCari" id="FCari" class="hidden-print">
  <div class="input-group">
    <input name="txtcari" value="<?php echo $txtcari?>" type="text" class="form-control" placeholder="Masukkan NIS atau Nama">
    <span class="input-group-btn">
      <button class="btn btn-primary" type="submit" value="Cari">Cari!</button>
    </span>
  </div><!-- /input-group -->  
  </form>
  
  <?php
    $myquery="SELECT * FROM tb_siswa, tb_kelas, tb_jurusan WHERE NIS=$txtcari";
    $daftarsiswa=mysqli_query($conn, $myquery);
    $dataku=mysqli_fetch_array($daftarsiswa);
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
  
  <img src="../assets/img/gbr/logo_diknas2.png" align="left">
  <img src="../assets/img/gbr/logo-smk2.png" align="right">
  <div style="border-bottom:solid 2px" id="container">
  <div class="row">
  <h2 align="center"><b>SMK TEKNOLOGI PLUS PADANG</h2></b>
  <p align="center">
  Jl. Belanti Indah No. 5 Khatib Sulaiman, Padang</br>
  Telp. (0751) 7051030, Fax (0751) 446907</br>
  Email : teknologipluspadang@ymail.com</p>
  </div>
  </div>


  <table class="table table-bordered table-condensed" align="center">
  <thead>
      <tr>
        <td rowspan="2" align='center' width='40'><img src="../assets/img/noprofile.gif" width="40"></td>
        <th width='30'>NIS</td><td width='30'><?php echo $dataku['NIS'] ?></th>
        <th width='30'>Nama</td><td width='50'><?php echo $dataku['NamaSiswa'] ?></th>
      </tr>
        <tr>
        <th width='30'>Kelas</td><td width='30'><?php echo $dataku['NamaKls'] ?></th>
        <th width='30'>Jurusan</td><td width='50'><?php echo $dataku['NamaJrs'] ?></th>
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