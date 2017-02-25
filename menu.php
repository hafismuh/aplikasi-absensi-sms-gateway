<!-- Static navbar -->
<nav class="navbar navbar-default navbar-static-top">
<div class="container">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="http://localhost/AbsensiSmsGtw/index.php">Beranda</a>
  </div>

  <div id="navbar" class="collapse navbar-collapse">
    <ul class="nav navbar-nav">
    <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Data Master<span class="caret"></span></a>

    <ul class="dropdown-menu">
      <li><a href="http://localhost/AbsensiSmsGtw/siswa/data-siswa.php">Data Siswa</a></li>
      <li><a href="http://localhost/AbsensiSmsGtw/walas/data-walas.php">Data Walas</a></li>
      <li><a href="http://localhost/AbsensiSmsGtw/kelas/data-kls.php">Data Kelas</a></li>
      <li><a href="http://localhost/AbsensiSmsGtw/jurusan/data-jrs.php">Data Jurusan</a></li>
    </ul>

    <li><a href="http://localhost/AbsensiSmsGtw/absen/data-absensi.php">Absensi<span class="sr-only">(current)</span></a>
    </li>

    <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Laporan<span class="caret"></span></a>
    <ul class="dropdown-menu">
    <li><a href="http://localhost/AbsensiSmsGtw/absen/rekap-absensi.php">Rekapitulasi Absensi<span class="sr-only">(current)</span></a></li>
    <li><a href="http://localhost/AbsensiSmsGtw/absen/detail-absensi.php">Detail Absensi</a></li>
    </ul>
    </li>

    <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Layanan SMS<span class="caret"></span></a>
      <ul class="dropdown-menu">
        <li><a href="http://localhost/AbsensiSmsGtw/layanan/pesan-masuk.php">Pesan Masuk<span class="sr-only">(current)</span></a>
        </li>
        <li><a href="http://localhost/AbsensiSmsGtw/layanan/pesan-keluar.php">Pesan Keluar</a></li>
        <li><a href="http://localhost/AbsensiSmsGtw/layanan/server-sms.php" target="_blank">Server SMS</a></li>
      </ul>
    </li>
    </ul>

    <ul class="nav navbar-nav navbar-right">
    <li>
    <a><?php echo "Selamat datang, ".$_SESSION['NamaPtg'];?></a>
    </li>
    <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Petugas<span class="caret"></span></a>
    <ul class="dropdown-menu">
    <li><a href="http://localhost/AbsensiSmsGtw/petugas/data-petugas.php">Data Petugas</a></li>
    <li><a href="http://localhost/AbsensiSmsGtw/logout.php">Keluar</a></li>
    </ul>
    </li>
    </ul>



  </div><!--/.nav-collapse -->
</div>
</nav>