-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 21 Jan 2017 pada 03.25
-- Versi Server: 10.1.9-MariaDB
-- PHP Version: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `absensigtw`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `daemons`
--

CREATE TABLE `daemons` (
  `Start` text NOT NULL,
  `Info` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `gammu`
--

CREATE TABLE `gammu` (
  `Version` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `gammu`
--

INSERT INTO `gammu` (`Version`) VALUES
(13);

-- --------------------------------------------------------

--
-- Struktur dari tabel `inbox`
--

CREATE TABLE `inbox` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ReceivingDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Text` text NOT NULL,
  `SenderNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT 'Default_No_Compression',
  `UDH` text NOT NULL,
  `SMSCNumber` varchar(20) NOT NULL DEFAULT '',
  `Class` int(11) NOT NULL DEFAULT '-1',
  `TextDecoded` varchar(150) NOT NULL,
  `ID` int(10) UNSIGNED NOT NULL,
  `RecipientID` text NOT NULL,
  `Processed` enum('false','true') NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `inbox`
--

INSERT INTO `inbox` (`UpdatedInDB`, `ReceivingDateTime`, `Text`, `SenderNumber`, `Coding`, `UDH`, `SMSCNumber`, `Class`, `TextDecoded`, `ID`, `RecipientID`, `Processed`) VALUES
('2016-08-23 03:24:01', '2016-08-23 03:23:43', '00430045004B00200041004200530045004E002000310036003000300031', '+6281277934310', 'Default_No_Compression', '', '+62811078801', -1, 'CEK ABSEN 16001', 2, 'phone1', 'true'),
('2016-10-04 09:59:36', '2016-10-04 09:59:13', '00430045004B00200041004200530045004E0020003100360036003000300031', '+6283193337758', 'Default_No_Compression', '', '+628315000032', -1, 'CEK ABSEN 166001', 3, 'phone1', 'true'),
('2016-10-04 10:02:46', '2016-10-04 10:02:16', '00430045004B0020004C00410050004F00520041004E0020003100360036003000300031', '+6283193337758', 'Default_No_Compression', '', '+628315000032', -1, 'CEK LAPORAN 166001', 4, 'phone1', 'true'),
('2016-10-05 06:32:26', '2016-10-05 06:31:59', '00430045004B00200041004200530045004E0020003100360036003000300031', '+6281216156777', 'Default_No_Compression', '', '+62811078801', -1, 'CEK ABSEN 166001', 5, 'phone1', 'true'),
('2016-10-05 06:34:22', '2016-10-05 06:33:55', '00430045004B0020004C00410050004F00520041004E0020003100360036003000300031', '+6281216156777', 'Default_No_Compression', '', '+62811078801', -1, 'CEK LAPORAN 166001', 6, 'phone1', 'true'),
('2016-10-05 06:36:18', '2016-10-05 06:35:49', '00430045004B0020006C00610070006F00720061006E0020003100360036003000300031', '+6281216156777', 'Default_No_Compression', '', '+62811078801', -1, 'CEK laporan 166001', 7, 'phone1', 'true'),
('2016-10-05 06:38:46', '2016-10-05 06:38:12', '00480061007200690020006C00610070006F00720061006E0020003100360036003000300031', '+6281534169353', 'Default_No_Compression', '', '+62816124', -1, 'Hari laporan 166001', 8, 'phone1', 'true');

--
-- Trigger `inbox`
--
DELIMITER $$
CREATE TRIGGER `inbox_timestamp` BEFORE INSERT ON `inbox` FOR EACH ROW BEGIN
    IF NEW.ReceivingDateTime = '0000-00-00 00:00:00' THEN
        SET NEW.ReceivingDateTime = CURRENT_TIMESTAMP();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `outbox`
--

CREATE TABLE `outbox` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SendingDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SendBefore` time NOT NULL DEFAULT '23:59:59',
  `SendAfter` time NOT NULL DEFAULT '00:00:00',
  `Text` text,
  `DestinationNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT 'Default_No_Compression',
  `UDH` text,
  `Class` int(11) DEFAULT '-1',
  `TextDecoded` text NOT NULL,
  `ID` int(10) UNSIGNED NOT NULL,
  `MultiPart` enum('false','true') DEFAULT 'false',
  `RelativeValidity` int(11) DEFAULT '-1',
  `SenderID` varchar(255) DEFAULT NULL,
  `SendingTimeOut` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `DeliveryReport` enum('default','yes','no') DEFAULT 'default',
  `CreatorID` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Trigger `outbox`
--
DELIMITER $$
CREATE TRIGGER `outbox_timestamp` BEFORE INSERT ON `outbox` FOR EACH ROW BEGIN
    IF NEW.InsertIntoDB = '0000-00-00 00:00:00' THEN
        SET NEW.InsertIntoDB = CURRENT_TIMESTAMP();
    END IF;
    IF NEW.SendingDateTime = '0000-00-00 00:00:00' THEN
        SET NEW.SendingDateTime = CURRENT_TIMESTAMP();
    END IF;
    IF NEW.SendingTimeOut = '0000-00-00 00:00:00' THEN
        SET NEW.SendingTimeOut = CURRENT_TIMESTAMP();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `outbox_multipart`
--

CREATE TABLE `outbox_multipart` (
  `Text` text,
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT 'Default_No_Compression',
  `UDH` text,
  `Class` int(11) DEFAULT '-1',
  `TextDecoded` text,
  `ID` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `SequencePosition` int(11) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pbk`
--

CREATE TABLE `pbk` (
  `ID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL DEFAULT '-1',
  `Name` text NOT NULL,
  `Number` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pbk_groups`
--

CREATE TABLE `pbk_groups` (
  `Name` text NOT NULL,
  `ID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `phones`
--

CREATE TABLE `phones` (
  `ID` text NOT NULL,
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TimeOut` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Send` enum('yes','no') NOT NULL DEFAULT 'no',
  `Receive` enum('yes','no') NOT NULL DEFAULT 'no',
  `IMEI` varchar(35) NOT NULL,
  `Client` text NOT NULL,
  `Battery` int(11) NOT NULL DEFAULT '-1',
  `Signal` int(11) NOT NULL DEFAULT '-1',
  `Sent` int(11) NOT NULL DEFAULT '0',
  `Received` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `phones`
--

INSERT INTO `phones` (`ID`, `UpdatedInDB`, `InsertIntoDB`, `TimeOut`, `Send`, `Receive`, `IMEI`, `Client`, `Battery`, `Signal`, `Sent`, `Received`) VALUES
('phone1', '2016-10-05 07:32:25', '2016-10-05 06:42:15', '2016-10-05 07:32:35', 'yes', 'yes', '860872012517885', 'Gammu 1.33.0, Windows Server 2007, GCC 4.7, MinGW 3.11', 0, 87, 0, 0);

--
-- Trigger `phones`
--
DELIMITER $$
CREATE TRIGGER `phones_timestamp` BEFORE INSERT ON `phones` FOR EACH ROW BEGIN
    IF NEW.InsertIntoDB = '0000-00-00 00:00:00' THEN
        SET NEW.InsertIntoDB = CURRENT_TIMESTAMP();
    END IF;
    IF NEW.TimeOut = '0000-00-00 00:00:00' THEN
        SET NEW.TimeOut = CURRENT_TIMESTAMP();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sentitems`
--

CREATE TABLE `sentitems` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SendingDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `DeliveryDateTime` timestamp NULL DEFAULT NULL,
  `Text` text NOT NULL,
  `DestinationNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT 'Default_No_Compression',
  `UDH` text NOT NULL,
  `SMSCNumber` varchar(20) NOT NULL DEFAULT '',
  `Class` int(11) NOT NULL DEFAULT '-1',
  `TextDecoded` text NOT NULL,
  `ID` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `SenderID` varchar(255) NOT NULL,
  `SequencePosition` int(11) NOT NULL DEFAULT '1',
  `Status` enum('SendingOK','SendingOKNoReport','SendingError','DeliveryOK','DeliveryFailed','DeliveryPending','DeliveryUnknown','Error') NOT NULL DEFAULT 'SendingOK',
  `StatusError` int(11) NOT NULL DEFAULT '-1',
  `TPMR` int(11) NOT NULL DEFAULT '-1',
  `RelativeValidity` int(11) NOT NULL DEFAULT '-1',
  `CreatorID` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `sentitems`
--

INSERT INTO `sentitems` (`UpdatedInDB`, `InsertIntoDB`, `SendingDateTime`, `DeliveryDateTime`, `Text`, `DestinationNumber`, `Coding`, `UDH`, `SMSCNumber`, `Class`, `TextDecoded`, `ID`, `SenderID`, `SequencePosition`, `Status`, `StatusError`, `TPMR`, `RelativeValidity`, `CreatorID`) VALUES
('2016-08-23 03:02:01', '2016-08-22 00:26:20', '2016-08-23 03:02:01', NULL, '004400610074006100200053006900730077006100200074006900640061006B00200064006900740065006D0075006B0061006E002C002000430065006B0020004B0065006D00620061006C00690020004E00490053', '081277934310', 'Default_No_Compression', '', '+62816124', -1, 'Data Siswa tidak ditemukan, Cek Kembali NIS', 1, 'phone1', 1, 'SendingOKNoReport', -1, 55, 255, ''),
('2016-08-23 03:24:06', '2016-08-23 03:24:00', '2016-08-23 03:24:06', NULL, '0032003000310036002D00300038002D0032003300200048006100660069007A00680020004B0065006C006100730020005800490020005400410056002000310020004B00650074006500720061006E00670061006E0020003A002000480061006400690072', '+6281277934310', 'Default_No_Compression', '', '+62816124', -1, '2016-08-23 Hafizh Kelas XI TAV 1 Keterangan : Hadir', 2, 'phone1', 1, 'SendingOKNoReport', -1, 56, 255, ''),
('2016-10-05 06:36:42', '2016-10-05 06:36:18', '2016-10-05 06:36:42', NULL, '00530074006100740069007300740069006B0020004B0065006800610064006900720061006E002000410066007200690063006F00200043006800610065006600720069002000200020004B0065006C00610073003A00200058002000540041005600200031002000620075006C0061006E00200069006E0069003A0020004D006100730075006B003A00200032002E002000530061006B00690074003A00200030002E00200049007A0069006E003A00200030002E00200041006C00700061003A00200030', '+6281216156777', 'Default_No_Compression', '', '+62818445009', -1, 'Statistik Kehadiran Africo Chaefri   Kelas: X TAV 1 bulan ini: Masuk: 2. Sakit: 0. Izin: 0. Alpa: 0', 3, 'phone1', 1, 'SendingOKNoReport', -1, 5, 255, ''),
('2016-10-05 06:39:18', '2016-10-05 06:38:46', '2016-10-05 06:39:18', NULL, '004D00610061006600200066006F0072006D0061007400200053004D005300200041006E00640061002000730061006C00610068002E0020004B006500740069006B002000430045004B0020002800730070006100730069002900200041004200530045004E002000280073007000610073006900290020004E0049005300200061007400610075002000430045004B002000280073007000610073006900290020004C00410050004F00520041004E002000280073007000610073006900290020004E00490053', '+6281534169353', 'Default_No_Compression', '', '+62818445009', -1, 'Maaf format SMS Anda salah. Ketik CEK (spasi) ABSEN (spasi) NIS atau CEK (spasi) LAPORAN (spasi) NIS', 4, 'phone1', 1, 'SendingOKNoReport', -1, 6, 255, '');

--
-- Trigger `sentitems`
--
DELIMITER $$
CREATE TRIGGER `sentitems_timestamp` BEFORE INSERT ON `sentitems` FOR EACH ROW BEGIN
    IF NEW.InsertIntoDB = '0000-00-00 00:00:00' THEN
        SET NEW.InsertIntoDB = CURRENT_TIMESTAMP();
    END IF;
    IF NEW.SendingDateTime = '0000-00-00 00:00:00' THEN
        SET NEW.SendingDateTime = CURRENT_TIMESTAMP();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_absen`
--

CREATE TABLE `tb_absen` (
  `KodeAbsen` int(3) NOT NULL,
  `TglAbsen` date NOT NULL,
  `NIS` int(6) NOT NULL,
  `KetAbsen` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_absen`
--

INSERT INTO `tb_absen` (`KodeAbsen`, `TglAbsen`, `NIS`, `KetAbsen`) VALUES
(1, '2016-08-16', 16001, 'Hadir'),
(2, '2016-08-16', 16002, 'Hadir'),
(3, '2016-08-16', 16003, 'Hadir'),
(4, '2016-08-16', 16004, 'Hadir'),
(5, '2016-08-16', 16005, 'Hadir'),
(6, '2016-08-15', 16001, 'Izin'),
(7, '2016-08-15', 16002, 'Alpa'),
(8, '2016-08-15', 16003, 'Hadir'),
(9, '2016-08-15', 16004, 'Izin'),
(10, '2016-08-15', 16005, 'Izin'),
(11, '2016-08-14', 16001, 'Hadir'),
(12, '2016-08-14', 16002, 'Hadir'),
(13, '2016-08-14', 16003, 'Hadir'),
(14, '2016-08-14', 16004, 'Hadir'),
(15, '2016-08-14', 16005, 'Hadir'),
(16, '2016-08-13', 16001, 'Hadir'),
(17, '2016-08-13', 16002, 'Hadir'),
(18, '2016-08-13', 16003, 'Hadir'),
(19, '2016-08-13', 16004, 'Hadir'),
(20, '2016-08-13', 16005, 'Hadir'),
(21, '2016-08-17', 16001, 'Hadir'),
(22, '2016-08-17', 16002, 'Hadir'),
(23, '2016-08-17', 16003, 'Alpa'),
(24, '2016-08-17', 16004, 'Alpa'),
(25, '2016-08-17', 16005, 'Sakit'),
(26, '2016-08-18', 16001, 'Izin'),
(27, '2016-08-18', 16002, 'Izin'),
(28, '2016-08-18', 16003, 'Hadir'),
(29, '2016-08-18', 16004, 'Hadir'),
(30, '2016-08-18', 16005, 'Hadir'),
(31, '2016-08-23', 16001, 'Hadir'),
(32, '2016-08-23', 16002, 'Hadir'),
(33, '2016-08-23', 16003, 'Hadir'),
(34, '2016-08-23', 16004, 'Hadir'),
(35, '2016-08-23', 16005, 'Hadir'),
(36, '2016-08-24', 16001, 'Sakit'),
(37, '2016-08-24', 16002, 'Hadir'),
(38, '2016-08-24', 16003, 'Hadir'),
(39, '2016-08-24', 16004, 'Hadir'),
(40, '2016-08-24', 16005, 'Hadir'),
(41, '2016-10-04', 166001, 'Hadir'),
(42, '2016-10-04', 166002, 'Hadir'),
(43, '2016-10-04', 166003, 'Izin'),
(44, '2016-10-04', 166004, 'Hadir'),
(45, '2016-10-04', 166005, 'Hadir'),
(46, '2016-10-04', 166006, 'Hadir'),
(47, '2016-10-04', 166007, 'Alpa'),
(48, '2016-10-04', 166008, 'Hadir'),
(49, '2016-10-04', 166018, 'Hadir'),
(50, '2016-10-04', 166017, 'Hadir'),
(51, '2016-10-04', 166016, 'Hadir'),
(52, '2016-10-04', 166009, 'Izin'),
(53, '2016-10-04', 166013, 'Hadir'),
(54, '2016-10-04', 166015, 'Hadir'),
(55, '2016-10-04', 166014, 'Hadir'),
(56, '2016-10-04', 166011, 'Alpa'),
(57, '2016-10-04', 166010, 'Hadir'),
(58, '2016-10-04', 166012, 'Hadir'),
(59, '2016-10-05', 166001, 'Hadir'),
(60, '2016-10-06', 166001, 'Alpa'),
(61, '2016-10-06', 166019, 'Hadir'),
(62, '2016-10-07', 166001, 'Hadir'),
(63, '2016-10-08', 166001, 'Izin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_jurusan`
--

CREATE TABLE `tb_jurusan` (
  `KodeJrs` int(2) NOT NULL,
  `NamaJrs` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_jurusan`
--

INSERT INTO `tb_jurusan` (`KodeJrs`, `NamaJrs`) VALUES
(11, 'Teknik Audio Video'),
(12, 'Teknik Multimedia'),
(13, 'Teknik Kendaraan Ringan'),
(14, 'Teknik Sepeda Motor');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kelas`
--

CREATE TABLE `tb_kelas` (
  `KodeKls` int(3) NOT NULL,
  `NamaKls` varchar(10) NOT NULL,
  `KodeJrs` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_kelas`
--

INSERT INTO `tb_kelas` (`KodeKls`, `NamaKls`, `KodeJrs`) VALUES
(101, 'X TAV 1', 11),
(102, 'X MM 1', 12),
(103, 'X MM 2', 12),
(104, 'X TKR 1', 13),
(105, 'X TKR 2', 13),
(106, 'X TSM 1', 14),
(107, 'X TSM 2', 14),
(111, 'XI TAV 1', 11),
(112, 'XI MM 1', 12),
(113, 'XI TKR 1', 13),
(114, 'XI TSM 1', 14),
(121, 'XII TAV 1', 11),
(122, 'XII MM 1', 12),
(123, 'XII TKR 1', 13),
(124, 'XII TKR 2', 13),
(125, 'XII TSM 1', 14);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_petugas`
--

CREATE TABLE `tb_petugas` (
  `NamaPtg` varchar(25) CHARACTER SET latin1 NOT NULL,
  `NamaPgn` varchar(25) CHARACTER SET latin1 NOT NULL,
  `Sandi` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_petugas`
--

INSERT INTO `tb_petugas` (`NamaPtg`, `NamaPgn`, `Sandi`) VALUES
('Administrator', 'admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_siswa`
--

CREATE TABLE `tb_siswa` (
  `NIS` int(6) NOT NULL,
  `NamaSiswa` varchar(50) NOT NULL,
  `JenisKelamin` varchar(10) NOT NULL,
  `TempatLahir` varchar(50) NOT NULL,
  `TanggalLahir` date NOT NULL,
  `Agama` varchar(10) NOT NULL,
  `AlamatSiswa` varchar(50) NOT NULL,
  `KodeKls` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_siswa`
--

INSERT INTO `tb_siswa` (`NIS`, `NamaSiswa`, `JenisKelamin`, `TempatLahir`, `TanggalLahir`, `Agama`, `AlamatSiswa`, `KodeKls`) VALUES
(1501, 'MUHAMMAD FALAH RAZAQ N.', 'Laki-laki', 'Padang', '1998-07-08', 'Islam', 'Padang', 112),
(1502, 'RAHMAN FIKRI HAKIKAL', 'Laki-laki', 'Padang', '1998-07-12', 'Islam', 'Padang', 112),
(1503, 'SALMA SALSABILLA PUTRI Y', 'Laki-laki', 'Padang', '1998-07-15', 'Islam', 'Padang', 112),
(1504, 'TEDDY NOVIANDI F', 'Laki-laki', 'Padang', '1998-07-19', 'Islam', 'Padang', 112),
(1505, 'WAHYU RAMADHAN', 'Laki-laki', 'Padang', '1998-07-20', 'Islam', 'Padang', 112),
(1506, 'YUDITTIRA GUNAWAN PUTRA', 'Laki-laki', 'Padang', '1998-08-17', 'Islam', 'Padang', 113),
(1507, 'RAHMAD HARYA SAPUTRA', 'Laki-laki', 'Padang', '1998-09-16', 'Islam', 'Padang', 114),
(1508, 'RIDO ARFANDI', 'Laki-laki', 'Padang', '1998-09-21', 'Islam', 'Padang', 114),
(1509, 'RYANDI KURNIAWAN', 'Laki-laki', 'Padang', '1998-09-22', 'Islam', 'Padang', 114),
(1510, 'SYARIFUL HIDAYAH', 'Laki-laki', 'Padang', '1998-09-23', 'Islam', 'Padang', 114),
(1511, 'ZAGHI ANAKUYAMA PARE ', 'Laki-laki', 'Padang', '1998-09-25', 'Islam', 'Padang', 114),
(1512, 'RIO OKTAVIANDRI', 'Laki-laki', 'Padang', '1998-10-04', 'Islam', 'Padang', 121),
(1513, 'RAHMAT DANI', 'Laki-laki', 'Padang', '1998-11-03', 'Islam', 'Padang', 122),
(1514, 'RAMADHAN', 'Laki-laki', 'Padang', '1998-11-04', 'Islam', 'Padang', 122),
(1515, 'YAHYA AYYAS PRATAMA', 'Laki-laki', 'Padang', '1998-11-10', 'Islam', 'Padang', 122),
(1516, 'AFDAL MAHENDRI', 'Laki-laki', 'Padang', '1998-11-11', 'Islam', 'Padang', 123),
(1517, 'ANSHORULLAH', 'Laki-laki', 'Padang', '1998-11-12', 'Islam', 'Padang', 123),
(1518, 'ARI RAHMAT ILAHI', 'Laki-laki', 'Padang', '1998-11-13', 'Islam', 'Padang', 123),
(1519, 'DIO PRATAMA PUTRA', 'Laki-laki', 'Padang', '1998-11-14', 'Islam', 'Padang', 123),
(1520, 'DENY SISWOYO', 'Laki-laki', 'Padang', '1998-11-15', 'Islam', 'Padang', 123),
(1521, 'M. IQBAL PRATAMA', 'Laki-laki', 'Padang', '1998-11-18', 'Islam', 'Padang', 123),
(1522, 'MUHAMMAD ARIF', 'Laki-laki', 'Padang', '1998-11-19', 'Islam', 'Padang', 123),
(1523, 'REZA ISA BELLA KARISMA', 'Laki-laki', 'Padang', '1998-11-27', 'Islam', 'Padang', 123),
(1524, 'RIDHO IRWAN', 'Laki-laki', 'Padang', '1998-11-28', 'Islam', 'Padang', 123),
(1525, 'ROREZ', 'Laki-laki', 'Padang', '1998-12-01', 'Islam', 'Padang', 123),
(1526, 'WAHYU DANANG PRASETYO', 'Laki-laki', 'Padang', '1998-12-04', 'Islam', 'Padang', 123),
(1527, 'WINDO INDRAMA', 'Laki-laki', 'Padang', '1998-12-05', 'Islam', 'Padang', 123),
(1528, 'YOSEF HAMONANGAN', 'Laki-laki', 'Padang', '1998-12-07', 'Islam', 'Padang', 123),
(1529, 'YUDI IRFINDRA', 'Laki-laki', 'Padang', '1998-12-08', 'Islam', 'Padang', 123),
(1530, 'AHDI INDRA', 'Laki-Laki', 'X', '1995-08-05', 'Islam', 'X', 125),
(1531, 'DANDI WILANDO', 'Laki-Laki', 'X', '2016-10-07', 'Islam', 'X', 125),
(1532, 'RAHMAT DANIEL', 'Laki-Laki', 'X', '2016-10-07', 'Islam', 'X', 125),
(1533, 'RIZKI MUHAMMAD RIDWAN', 'Laki-Laki', 'X', '2016-10-07', 'Islam', 'X', 125),
(1534, 'TIO SAPUTRA', 'Laki-Laki', 'X', '2016-10-07', 'Katolik', 'X', 125),
(1535, 'ZAQI ALFADRI', 'Laki-Laki', 'X', '2016-10-07', 'Katolik', 'X', 125),
(1536, 'ADE MUHARMAN', 'Laki-laki', 'Padang', '1998-12-23', 'Islam', 'Padang', 125),
(1537, 'KELLVIN CHANDRA', 'Laki-laki', 'Padang', '1999-01-05', 'Islam', 'Padang', 125),
(1538, 'SEMBER YANTO TAFONAIO', 'Laki-laki', 'Padang', '1999-01-13', 'Islam', 'Padang', 125),
(1539, 'TOBENUS JAGEL LEPPAK', 'Laki-laki', 'Padang', '1999-01-16', 'Islam', 'Padang', 125),
(145001, 'RANGGA RAFSANJANI', 'Laki-laki', 'Padang', '1998-12-19', 'Islam', 'Padang', 124),
(145002, 'ADE SAPUTRA', 'Laki-laki', 'Padang', '1998-12-24', 'Islam', 'Padang', 125),
(145003, 'AGIL AZHARI', 'Laki-laki', 'Padang', '1998-12-25', 'Islam', 'Padang', 125),
(145004, 'ALDO SAPUTRA', 'Laki-laki', 'Padang', '1998-12-26', 'Islam', 'Padang', 125),
(145007, 'ANDI IRAWAN', 'Laki-laki', 'Padang', '1998-12-27', 'Islam', 'Padang', 125),
(145010, 'ANES SAPUTRA ', 'Laki-laki', 'Padang', '1998-12-28', 'Islam', 'Padang', 125),
(145020, 'EDO SULISTIO', 'Laki-laki', 'Padang', '1998-12-11', 'Islam', 'Padang', 124),
(145022, 'EMIL ABRAR', 'Laki-laki', 'Padang', '1998-12-12', 'Islam', 'Padang', 124),
(145025, 'FANDI AULIA', 'Laki-laki', 'Padang', '1998-12-13', 'Islam', 'Padang', 124),
(145030, 'ILHAM BENI PUTA', 'Laki-laki', 'Padang', '1998-12-14', 'Islam', 'Padang', 124),
(145031, 'ILHAM YURIZAL', 'Laki-laki', 'Padang', '1998-12-15', 'Islam', 'Padang', 124),
(145038, 'HELMI MUHAMMAD PUTRA', 'Laki-laki', 'Padang', '1998-11-16', 'Islam', 'Padang', 123),
(145039, 'M HENDRA SAPUTRA', 'Laki-laki', 'Padang', '1998-11-17', 'Islam', 'Padang', 123),
(145042, 'MUHAMMAD ABIMANYU F', 'Laki-laki', 'Padang', '1999-01-06', 'Islam', 'Padang', 125),
(145044, 'MUHAMMAD ALLIEF', 'Laki-laki', 'Padang', '1998-12-16', 'Islam', 'Padang', 124),
(145047, 'MUHAMMAD ARRAHMANSYAH', 'Laki-laki', 'Padang', '1998-11-20', 'Islam', 'Padang', 123),
(145048, 'MUHAMMAD RAIS', 'Laki-laki', 'Padang', '1999-01-07', 'Islam', 'Padang', 125),
(145049, 'MUHAMMAD FATIH', 'Laki-laki', 'Padang', '1998-11-21', 'Islam', 'Padang', 123),
(145050, 'NANDITO FEBRIAN', 'Laki-laki', 'Padang', '1998-11-22', 'Islam', 'Padang', 123),
(145051, 'POLTAK SIMBOLON', 'Laki-laki', 'Padang', '1998-11-23', 'Islam', 'Padang', 123),
(145052, 'RADI AKBAR TANJUNG', 'Laki-laki', 'Padang', '1999-01-08', 'Islam', 'Padang', 125),
(145053, 'RAFIL GUSMAINALDI', 'Laki-laki', 'Padang', '1999-01-09', 'Islam', 'Padang', 125),
(145054, 'RACHMAT PUTRA PRATAMA', 'Laki-laki', 'Padang', '1998-11-24', 'Islam', 'Padang', 123),
(145055, 'RAHMAT HIDAYAT', 'Laki-laki', 'Padang', '1998-11-25', 'Islam', 'Padang', 123),
(145057, 'RAYENDRA PUTRA', 'Laki-laki', 'Padang', '1999-01-10', 'Islam', 'Padang', 125),
(145058, 'RANDA JHONIFER', 'Laki-laki', 'Padang', '1998-11-26', 'Islam', 'Padang', 123),
(145059, 'ROBI ANDIKA MASPUTRA', 'Laki-laki', 'Padang', '1998-11-30', 'Islam', 'Padang', 123),
(145062, 'TRI PAJRI YONNI PUTRA', 'Laki-laki', 'Padang', '1998-12-02', 'Islam', 'Padang', 123),
(145063, 'VRIZKA APRIANA DEPRI', 'Laki-laki', 'Padang', '1998-12-03', 'Islam', 'Padang', 123),
(145064, 'WAHYUDI EGO PUTRA', 'Laki-laki', 'Padang', '1999-01-18', 'Islam', 'Padang', 125),
(145065, 'YANUARDI LASE', 'Laki-laki', 'Padang', '1998-12-06', 'Islam', 'Padang', 123),
(145078, 'ARIO DWI PANGGA', 'Laki-laki', 'Padang', '1998-12-29', 'Islam', 'Padang', 125),
(145084, 'DIKI ABDILLAH B JUFRAN', 'Laki-laki', 'Padang', '1998-12-30', 'Islam', 'Padang', 125),
(145087, 'EPRI YUDA', 'Laki-laki', 'Padang', '1998-12-31', 'Islam', 'Padang', 125),
(145089, 'FAJRUL FALAQ ALFAHSYA', 'Laki-laki', 'Padang', '1999-01-01', 'Islam', 'Padang', 125),
(145091, 'FARIQ MUHAMMAD', 'Laki-laki', 'Padang', '1999-01-02', 'Islam', 'Padang', 125),
(145093, 'IHSANUL KHAIRI HASMIN', 'Laki-laki', 'Padang', '1999-01-03', 'Islam', 'Padang', 125),
(145095, 'IRVANUS BUULOLO', 'Laki-laki', 'Padang', '1999-01-04', 'Islam', 'Padang', 125),
(145101, 'MUHAMAD RIFKY RAMBE', 'Laki-laki', 'Padang', '1998-12-17', 'Islam', 'Padang', 124),
(145112, 'RENDI JANUAR PUTRA', 'Laki-laki', 'Padang', '1999-01-11', 'Islam', 'Padang', 125),
(145116, 'RIKI SUBARJA', 'Laki-laki', 'Padang', '1998-11-29', 'Islam', 'Padang', 123),
(145118, 'SARUDIN SARUBEI', 'Laki-laki', 'Padang', '1999-01-12', 'Islam', 'Padang', 125),
(145119, 'SHAN SEBASTIAN WIBOWO', 'Laki-laki', 'Padang', '1999-01-14', 'Islam', 'Padang', 125),
(145120, 'SYAFRIYATDI', 'Laki-laki', 'Padang', '1999-01-15', 'Islam', 'Padang', 125),
(145123, 'TULUS PARLINDUNGAN M.', 'Laki-laki', 'Padang', '1999-01-17', 'Islam', 'Padang', 125),
(145124, 'YOVAL HARPIN USMAN', 'Laki-laki', 'Padang', '1999-01-19', 'Islam', 'Padang', 125),
(145125, 'YUYUN TRINIAMAN GEA', 'Perempuan', 'Padang', '1999-01-20', 'Islam', 'Padang', 125),
(145127, 'ALBINA SABULAU', 'Laki-laki', 'Padang', '1998-09-26', 'Islam', 'Padang', 121),
(145131, 'ELSA SUSANTI', 'Perempuan', 'Padang', '1998-09-27', 'Islam', 'Padang', 121),
(145132, 'FAUZAN RAFIQAL''ALA', 'Laki-laki', 'Padang', '1998-09-28', 'Islam', 'Padang', 121),
(145134, 'JERRI RAHMAT VALJEAN', 'Laki-laki', 'Padang', '1998-09-29', 'Islam', 'Padang', 121),
(145137, 'NANANG PUJI SUPRIATNA', 'Laki-laki', 'Padang', '1998-09-30', 'Islam', 'Padang', 121),
(145138, 'NURAZIZA SARUBEI', 'Perempuan', 'Padang', '1998-10-01', 'Islam', 'Padang', 121),
(145139, 'RAHMADHAN', 'Laki-laki', 'Padang', '1998-10-02', 'Islam', 'Padang', 121),
(145141, 'RINI SUSANTI', 'Perempuan', 'Padang', '1998-10-03', 'Islam', 'Padang', 121),
(145142, 'RIZKY FIRMANSYAH', 'Laki-laki', 'Padang', '1998-10-05', 'Islam', 'Padang', 121),
(145144, 'SALMAN PARIZI', 'Laki-laki', 'Padang', '1998-10-06', 'Islam', 'Padang', 121),
(145146, 'SINTIA LORNA', 'Perempuan', 'Padang', '1998-10-07', 'Islam', 'Padang', 121),
(145147, 'SRI WULAN PURNAMASARI', 'Perempuan', 'Padang', '1998-10-08', 'Islam', 'Padang', 121),
(145148, 'SYAHRUZA FAHLERI', 'Laki-laki', 'Padang', '1998-10-09', 'Islam', 'Padang', 121),
(145149, 'WAHYUDI', 'Laki-laki', 'Padang', '1998-10-10', 'Islam', 'Padang', 121),
(145150, 'YANMA GUSTI BAKRI', 'Laki-laki', 'Padang', '1998-10-11', 'Islam', 'Padang', 121),
(145151, 'ABDUL HAMID', 'Laki-laki', 'Padang', '1998-10-12', 'Islam', 'Padang', 122),
(145152, 'ADILLA SUSANTI', 'Laki-laki', 'Padang', '1998-10-13', 'Islam', 'Padang', 122),
(145153, 'AGNESIA MONICA', 'Perempuan', 'Padang', '1998-10-14', 'Islam', 'Padang', 122),
(145154, 'ALIF FATKHUR ROJIQ', 'Laki-laki', 'Padang', '1998-10-15', 'Islam', 'Padang', 122),
(145155, 'ALZIKRI LISMAN', 'Laki-laki', 'Padang', '1998-10-16', 'Islam', 'Padang', 122),
(145156, 'ANDRIANTO SAPUTRA', 'Laki-laki', 'Padang', '1998-10-17', 'Islam', 'Padang', 122),
(145157, 'ARIF RAHMAN P', 'Laki-laki', 'Padang', '1998-10-18', 'Islam', 'Padang', 122),
(145158, 'AYU AGMARINA', 'Perempuan', 'Padang', '1998-10-19', 'Islam', 'Padang', 122),
(145159, 'CHARLES SOIBI SADODOLU', 'Laki-laki', 'Padang', '1998-10-20', 'Islam', 'Padang', 122),
(145160, 'GOVAL RAHMANDA', 'Laki-laki', 'Padang', '1998-10-21', 'Islam', 'Padang', 122),
(145161, 'HANDRI SETIAWAN', 'Laki-laki', 'Padang', '1998-10-22', 'Islam', 'Padang', 122),
(145162, 'HIDAYAT', 'Laki-laki', 'Padang', '1998-10-23', 'Islam', 'Padang', 122),
(145163, 'JEFFRI RAMADHAN', 'Laki-laki', 'Padang', '1998-10-24', 'Islam', 'Padang', 122),
(145164, 'KEMAL RAHMAN DENIS', 'Laki-laki', 'Padang', '1998-10-25', 'Islam', 'Padang', 122),
(145165, 'KURNIA NUR SITI ERLINA ', 'Laki-laki', 'Padang', '1998-10-26', 'Islam', 'Padang', 122),
(145166, 'M. FAZRI ZAKARIA', 'Laki-laki', 'Padang', '1998-10-27', 'Islam', 'Padang', 122),
(145167, 'M. NUGRAHA YUSRIZA', 'Laki-laki', 'Padang', '1998-10-28', 'Islam', 'Padang', 122),
(145168, 'MATTO RUDIN SIRITOITET', 'Laki-laki', 'Padang', '1998-10-29', 'Islam', 'Padang', 122),
(145169, 'MUHAMMAD HANAFI AKBAR', 'Laki-laki', 'Padang', '1998-10-30', 'Islam', 'Padang', 122),
(145170, 'MUHAMMAD SIDIK', 'Laki-laki', 'Padang', '1998-10-31', 'Islam', 'Padang', 122),
(145171, 'MUHSININ SATOUTOU', 'Laki-laki', 'Padang', '1998-11-01', 'Islam', 'Padang', 122),
(145173, 'PATRISIUS JONES RONALDO', 'Laki-laki', 'Padang', '1998-11-02', 'Islam', 'Padang', 122),
(145174, 'RAFLI FEBRIAH', 'Laki-laki', 'Padang', '1998-11-05', 'Islam', 'Padang', 122),
(145175, 'REFO AL FATHAN', 'Laki-laki', 'Padang', '1998-11-06', 'Islam', 'Padang', 122),
(145176, 'RENI ENGRIA SAPUTRI', 'Laki-laki', 'Padang', '1998-11-07', 'Islam', 'Padang', 122),
(145177, 'RIO YENERO', 'Laki-laki', 'Padang', '1998-11-08', 'Islam', 'Padang', 122),
(145180, 'SITI AISYAH', 'Perempuan', 'Padang', '1998-11-09', 'Islam', 'Padang', 122),
(155001, 'ALAN NOFRI', 'Laki-laki', 'Padang', '1998-06-12', 'Islam', 'Padang', 111),
(155002, 'AMELIA FEGA', 'Laki-laki', 'Padang', '1998-06-13', 'Islam', 'Padang', 111),
(155003, 'JONY EFENDI', 'Laki-laki', 'Padang', '1998-06-14', 'Islam', 'Padang', 111),
(155004, 'KHOLIDUN', 'Laki-laki', 'Padang', '1998-06-15', 'Islam', 'Padang', 111),
(155005, 'KHOLILUL AHMAD', 'Laki-laki', 'Padang', '1998-06-16', 'Islam', 'Padang', 111),
(155006, 'LILI MARISA JUNITA ', 'Laki-laki', 'Padang', '1998-06-17', 'Islam', 'Padang', 111),
(155007, 'MUHAMMAD FAJRI', 'Laki-laki', 'Padang', '1998-06-18', 'Islam', 'Padang', 111),
(155008, 'MUHAMMAD TOMI', 'Laki-laki', 'Padang', '1998-06-19', 'Islam', 'Padang', 111),
(155012, 'TOBY MARFINUS', 'Laki-laki', 'Padang', '1998-06-20', 'Islam', 'Padang', 111),
(155013, 'YULIA HENDRIA PUTRI', 'Laki-laki', 'Padang', '1998-06-21', 'Islam', 'Padang', 111),
(155014, 'ABDUL RAHMAN ALFARISI', 'Laki-laki', 'Padang', '1998-06-22', 'Islam', 'Padang', 112),
(155015, 'ADITYA SMALKY', 'Laki-laki', 'Padang', '1998-06-23', 'Islam', 'Padang', 112),
(155016, 'ADITYA ERANTO PUTRA', 'Laki-laki', 'Padang', '1998-06-24', 'Islam', 'Padang', 112),
(155017, 'AFFAN AL QADRI', 'Laki-laki', 'Padang', '1998-06-25', 'Islam', 'Padang', 112),
(155018, 'AGO WIRABAKTI', 'Laki-laki', 'Padang', '1998-06-26', 'Islam', 'Padang', 112),
(155019, 'AL HADID QADRI', 'Laki-laki', 'Padang', '1998-06-27', 'Islam', 'Padang', 112),
(155020, 'ANDI BASO FURQHONI AL -AS''AD', 'Laki-laki', 'Padang', '1998-06-28', 'Islam', 'Padang', 112),
(155021, 'ANDRI RIZKILLAH', 'Laki-laki', 'Padang', '1998-06-29', 'Islam', 'Padang', 112),
(155024, 'DELVI DALIL RAHMATULLAH', 'Laki-laki', 'Padang', '1998-06-30', 'Islam', 'Padang', 112),
(155025, 'DINDA RUSLIANTI', 'Laki-laki', 'Padang', '1998-07-01', 'Islam', 'Padang', 112),
(155026, 'EFRIN EFENDI', 'Laki-laki', 'Padang', '1998-07-02', 'Islam', 'Padang', 112),
(155029, 'HARRY NUGRAHA', 'Laki-laki', 'Padang', '1998-07-03', 'Islam', 'Padang', 112),
(155030, 'IKHSAN ILHAMSYAH', 'Laki-laki', 'Padang', '1998-07-04', 'Islam', 'Padang', 112),
(155031, 'KEVIN ENO PUTRA', 'Laki-laki', 'Padang', '1998-07-05', 'Islam', 'Padang', 112),
(155032, 'MAHDI ISLAMI HANIF', 'Laki-laki', 'Padang', '1998-07-06', 'Islam', 'Padang', 112),
(155033, 'MARCCELINO HARRISKA', 'Laki-laki', 'Padang', '1998-07-07', 'Islam', 'Padang', 112),
(155037, 'PANJI MAHENDRA', 'Laki-laki', 'Padang', '1998-07-09', 'Islam', 'Padang', 112),
(155039, 'PURWANTO', 'Laki-laki', 'Padang', '1998-07-10', 'Islam', 'Padang', 112),
(155040, 'RANDIKA ISRAJ ADITYA', 'Laki-laki', 'Padang', '1998-07-11', 'Islam', 'Padang', 112),
(155041, 'REZA NOFRIALDI', 'Laki-laki', 'Padang', '1998-07-13', 'Islam', 'Padang', 112),
(155042, 'RIPO SAPUTRA', 'Laki-laki', 'Padang', '1998-07-14', 'Islam', 'Padang', 112),
(155046, 'SULTHAN ADHIMULLAH. A', 'Laki-laki', 'Padang', '1998-07-16', 'Islam', 'Padang', 112),
(155047, 'SUTOMO', 'Laki-laki', 'Padang', '1998-07-17', 'Islam', 'Padang', 112),
(155048, 'TASYA DASFA ANANDA', 'Laki-laki', 'Padang', '1998-07-18', 'Islam', 'Padang', 112),
(155050, 'WISNHU WARDANA BUTIDANG', 'Laki-laki', 'Padang', '1998-07-21', 'Islam', 'Padang', 112),
(155051, 'AGUS TRIANA', 'Laki-laki', 'Padang', '1998-07-22', 'Islam', 'Padang', 113),
(155052, 'ALDI IKRA PRAYUDHA', 'Laki-laki', 'Padang', '1998-07-23', 'Islam', 'Padang', 113),
(155053, 'ANGGI SYAHPUTRA PRATAMA', 'Laki-laki', 'Padang', '1998-07-24', 'Islam', 'Padang', 113),
(155054, 'CHANDRA ANDRESTA', 'Laki-laki', 'Padang', '1998-07-25', 'Islam', 'Padang', 113),
(155055, 'DANDI WAHYUDI ZAPIT', 'Laki-laki', 'Padang', '1998-07-26', 'Islam', 'Padang', 113),
(155056, 'DEDE YUSUF', 'Laki-laki', 'Padang', '1998-07-27', 'Islam', 'Padang', 113),
(155057, 'DIKI WAHYUDI', 'Laki-laki', 'Padang', '1998-07-28', 'Islam', 'Padang', 113),
(155059, 'GENTA ALIEF ISLAM PIJAR', 'Laki-laki', 'Padang', '1998-07-29', 'Islam', 'Padang', 113),
(155061, 'GILANG ARMANDO', 'Laki-laki', 'Padang', '1998-07-30', 'Islam', 'Padang', 113),
(155062, 'IRWANDI ', 'Laki-laki', 'Padang', '1998-07-31', 'Islam', 'Padang', 113),
(155063, 'ISKANDAR FAHMI', 'Laki-laki', 'Padang', '1998-08-01', 'Islam', 'Padang', 113),
(155065, 'MUHAMMAD AL FAYED', 'Laki-laki', 'Padang', '1998-08-02', 'Islam', 'Padang', 113),
(155066, 'MUHAMMAD ''ARIQSYAH', 'Laki-laki', 'Padang', '1998-08-03', 'Islam', 'Padang', 113),
(155069, 'MUHAMMAD PATRI', 'Laki-laki', 'Padang', '1998-08-04', 'Islam', 'Padang', 113),
(155070, 'OSVALDO ADVEN KURNIAWAN', 'Laki-laki', 'Padang', '1998-08-05', 'Islam', 'Padang', 113),
(155071, 'PUTRA ERMON', 'Laki-laki', 'Padang', '1998-08-06', 'Islam', 'Padang', 113),
(155075, 'RAYNALDO PERDANA', 'Laki-laki', 'Padang', '1998-08-07', 'Islam', 'Padang', 113),
(155076, 'REZA HANDIKA', 'Laki-laki', 'Padang', '1998-08-08', 'Islam', 'Padang', 113),
(155077, 'REZKI MAIZA PUTRA', 'Laki-laki', 'Padang', '1998-08-09', 'Islam', 'Padang', 113),
(155078, 'RICHARD ERYANTO GUSRIYONO', 'Laki-laki', 'Padang', '1998-08-10', 'Islam', 'Padang', 113),
(155079, 'RUDI S. PUTRA', 'Laki-laki', 'Padang', '1998-08-11', 'Islam', 'Padang', 113),
(155080, 'SADDAN ALI', 'Laki-laki', 'Padang', '1998-08-12', 'Islam', 'Padang', 113),
(155081, 'SATRIA MITRA WARDANA', 'Laki-laki', 'Padang', '1998-08-13', 'Islam', 'Padang', 113),
(155082, 'SIGIT KURNIAWAN', 'Laki-laki', 'Padang', '1998-08-14', 'Islam', 'Padang', 113),
(155084, 'TRI REZA RAMADHAN', 'Laki-laki', 'Padang', '1998-08-15', 'Islam', 'Padang', 113),
(155085, 'WANDO SAPUTRA', 'Laki-laki', 'Padang', '1998-08-16', 'Islam', 'Padang', 113),
(155087, 'ADI PUTRA', 'Laki-laki', 'Padang', '1998-08-18', 'Islam', 'Padang', 114),
(155088, 'AGUNG RAHMADI', 'Laki-laki', 'Padang', '1998-08-20', 'Islam', 'Padang', 114),
(155089, 'AIDIL HAMZI', 'Laki-laki', 'Padang', '1998-08-21', 'Islam', 'Padang', 114),
(155090, 'AKMAL GUNAWAN', 'Laki-laki', 'Padang', '1998-08-22', 'Islam', 'Padang', 114),
(155091, 'ALAM GURU HARAHAP', 'Laki-laki', 'Padang', '1998-08-23', 'Islam', 'Padang', 114),
(155092, 'ANDRIVA', 'Laki-laki', 'Padang', '1998-08-25', 'Islam', 'Padang', 114),
(155093, 'BERNAT', 'Laki-laki', 'Padang', '1998-08-27', 'Islam', 'Padang', 114),
(155094, 'DESMA IRWAN', 'Laki-laki', 'Padang', '1998-08-29', 'Islam', 'Padang', 114),
(155097, 'DONI LIZWARDI', 'Laki-laki', 'Padang', '1998-08-31', 'Islam', 'Padang', 114),
(155098, 'ERWIN SUBANDI ', 'Laki-laki', 'Padang', '1998-09-01', 'Islam', 'Padang', 114),
(155099, 'FERDHI RIZAL', 'Laki-laki', 'Padang', '1998-09-03', 'Islam', 'Padang', 114),
(155100, 'FIKRI WAFI', 'Laki-laki', 'Padang', '1998-09-04', 'Islam', 'Padang', 114),
(155101, 'HENDRI ANTONI', 'Laki-laki', 'Padang', '1998-09-07', 'Islam', 'Padang', 114),
(155103, 'M. PAJRUL HUMAINI', 'Laki-laki', 'Padang', '1998-09-08', 'Islam', 'Padang', 114),
(155105, 'MUHAMMAD ANIQ HANIF RAHMAN', 'Laki-laki', 'Padang', '1998-09-10', 'Islam', 'Padang', 114),
(155107, 'NIKOLAUS AGUS TRI KURNIAWAN', 'Laki-laki', 'Padang', '1998-09-11', 'Islam', 'Padang', 114),
(155108, 'NOVARDIANSYAH RIZKI', 'Laki-laki', 'Padang', '1998-09-13', 'Islam', 'Padang', 114),
(155109, 'RAHMA GANDHY', 'Laki-laki', 'Padang', '1998-09-15', 'Islam', 'Padang', 114),
(155110, 'RAMANDA BATU BARA', 'Laki-laki', 'Padang', '1998-09-18', 'Islam', 'Padang', 114),
(155112, 'RICE WAHYUDI KOTO', 'Laki-laki', 'Padang', '1998-09-20', 'Islam', 'Padang', 114),
(155113, 'THOMY MARFINDO', 'Laki-laki', 'Padang', '1998-09-24', 'Islam', 'Padang', 114),
(155115, 'AFDHAL DINIL HAQ', 'Laki-laki', 'Padang', '1998-08-19', 'Islam', 'Padang', 114),
(155117, 'ANDREAN FERNANDES', 'Laki-laki', 'Padang', '1998-08-24', 'Islam', 'Padang', 114),
(155119, 'ARI YOLANDA MUSLIM', 'Laki-laki', 'Padang', '1998-08-26', 'Islam', 'Padang', 114),
(155120, 'DIMAS WAHYUDI PRATAMA', 'Laki-laki', 'Padang', '1998-08-30', 'Islam', 'Padang', 114),
(155122, 'DERMAWAN', 'Laki-laki', 'Padang', '1998-08-28', 'Islam', 'Padang', 114),
(155123, 'FAJAR ISKANDAR', 'Laki-laki', 'Padang', '1998-09-02', 'Islam', 'Padang', 114),
(155124, 'GENTA NICOLA', 'Laki-laki', 'Padang', '1998-09-05', 'Islam', 'Padang', 114),
(155125, 'GIAN FRANATA', 'Laki-laki', 'Padang', '1998-09-06', 'Islam', 'Padang', 114),
(155126, 'MARIO ARJUNA', 'Laki-laki', 'Padang', '1998-09-09', 'Islam', 'Padang', 114),
(155129, 'NOBER SATRIA MURDI', 'Laki-laki', 'Padang', '1998-09-12', 'Islam', 'Padang', 114),
(155133, 'RAFLI RAHMADANI', 'Laki-laki', 'Padang', '1998-09-14', 'Islam', 'Padang', 114),
(155134, 'RAMADANI TRIO PUTERA', 'Laki-laki', 'Padang', '1998-09-17', 'Islam', 'Padang', 114),
(155136, 'REZKY PUTRA ANDINATA', 'Laki-laki', 'Padang', '1998-09-19', 'Islam', 'Padang', 114),
(166001, 'Africo Chaefri  ', 'Laki-laki', 'Padang', '1998-01-01', 'Islam', 'Bukittinggi', 101),
(166002, 'Akmal Fuad', 'Laki-laki', 'Padang', '1998-01-02', 'Islam', 'Padang', 101),
(166003, 'Ali Saputra', 'Laki-laki', 'Padang', '1998-01-03', 'Islam', 'Padang', 101),
(166004, 'Aris Pratama', 'Laki-laki', 'Padang', '1998-01-04', 'Islam', 'Padang', 101),
(166005, 'Ardiyanto', 'Laki-laki', 'Padang', '1998-01-05', 'Islam', 'Padang', 101),
(166006, 'Azli Rahman Syafmi', 'Laki-laki', 'Padang', '1998-01-06', 'Islam', 'Padang', 101),
(166007, 'Bebi Yola', 'Laki-laki', 'Padang', '1998-01-07', 'Islam', 'Padang', 101),
(166008, 'Boyke Nugraha', 'Laki-laki', 'Padang', '1998-01-08', 'Islam', 'Padang', 101),
(166009, 'Geovani Adrian', 'Laki-laki', 'Padang', '1998-01-09', 'Islam', 'Padang', 101),
(166010, 'Jimy Saputra', 'Laki-laki', 'Padang', '1998-01-10', 'Islam', 'Padang', 101),
(166011, 'Khairul Abdul Ralif', 'Laki-laki', 'Padang', '1998-01-11', 'Islam', 'Padang', 101),
(166012, 'Muhammad Palestin Arabi', 'Laki-laki', 'Padang', '1998-01-12', 'Islam', 'Padang', 101),
(166013, 'Nalduarno', 'Laki-laki', 'Padang', '1998-01-13', 'Islam', 'Padang', 101),
(166014, 'Natasya Regita Cahyani', 'Laki-laki', 'Padang', '1998-01-14', 'Islam', 'Padang', 101),
(166015, 'Romario', 'Laki-laki', 'Padang', '1998-01-15', 'Islam', 'Padang', 101),
(166016, 'Tri Novita Sari', 'Perempuan', 'Padang', '1998-01-16', 'Islam', 'Padang', 101),
(166017, 'Utami Isman', 'Laki-laki', 'Padang', '1998-01-17', 'Islam', 'Padang', 101),
(166018, 'Wahyudi Ramadhan Saputra', 'Laki-laki', 'Padang', '1998-01-18', 'Islam', 'Padang', 101),
(166019, 'Airlangga Rambuci', 'Laki-laki', 'Padang', '1998-01-19', 'Islam', 'Padang', 102),
(166020, 'Alfarabi Novrian.A', 'Laki-laki', 'Padang', '1998-01-20', 'Islam', 'Padang', 102),
(166021, 'Andre Karta Dinata', 'Laki-laki', 'Padang', '1998-01-21', 'Islam', 'Padang', 102),
(166022, 'Arrich Adexy Bayu', 'Laki-laki', 'Padang', '1998-01-22', 'Islam', 'Padang', 102),
(166023, 'Audensi Dermawan', 'Laki-laki', 'Padang', '1998-01-23', 'Islam', 'Padang', 102),
(166024, 'Brata Jingga Rontoe', 'Laki-laki', 'Padang', '1998-01-24', 'Islam', 'Padang', 102),
(166025, 'Desmonda Barca Amanta', 'Perempuan', 'Padang', '1998-01-25', 'Islam', 'Padang', 102),
(166026, 'Dimas Raynata', 'Laki-laki', 'Padang', '1998-01-26', 'Islam', 'Padang', 102),
(166027, 'Elsa Briola Dhimeltra.Gs', 'Perempuan', 'Padang', '1998-01-27', 'Islam', 'Padang', 102),
(166028, 'Farhan Maulana', 'Laki-laki', 'Padang', '1998-01-28', 'Islam', 'Padang', 102),
(166029, 'Feby Wirya Nanda Hernandes', 'Laki-laki', 'Padang', '1998-01-29', 'Islam', 'Padang', 102),
(166030, 'Indah Wardani', 'Perempuan', 'Padang', '1998-01-30', 'Islam', 'Padang', 102),
(166031, 'Jimmi Jannet Siahaan', 'Laki-laki', 'Padang', '1998-01-31', 'Islam', 'Padang', 102),
(166032, 'Kaspila', 'Laki-laki', 'Padang', '1998-02-01', 'Islam', 'Padang', 102),
(166033, 'Marliana Feronica Putri', 'Laki-laki', 'Padang', '1998-02-02', 'Islam', 'Padang', 102),
(166034, 'Monang Ramadhan', 'Laki-laki', 'Padang', '1998-02-03', 'Islam', 'Padang', 102),
(166035, 'Muhammad Fikri Haikal', 'Laki-laki', 'Padang', '1998-02-04', 'Islam', 'Padang', 102),
(166036, 'Muhammad Musa Zulkarnain', 'Laki-laki', 'Padang', '1998-02-05', 'Islam', 'Padang', 102),
(166037, 'Muhammad Syahrul Novrianto', 'Laki-laki', 'Padang', '1998-02-06', 'Islam', 'Padang', 102),
(166038, 'Rafi Ilham', 'Laki-laki', 'Padang', '1998-02-07', 'Islam', 'Padang', 102),
(166039, 'Reyza Andika Putra', 'Laki-laki', 'Padang', '1998-02-08', 'Islam', 'Padang', 102),
(166040, 'Riando Sandopal Sihombing', 'Laki-laki', 'Padang', '1998-02-09', 'Islam', 'Padang', 102),
(166041, 'Rio Pranowo', 'Laki-laki', 'Padang', '1998-02-10', 'Islam', 'Padang', 102),
(166042, 'Tut Wuri Handayani', 'Perempuan', 'Padang', '1998-02-11', 'Islam', 'Padang', 102),
(166043, 'Dika Aprianti', 'Perempuan', 'Padang', '1998-02-12', 'Islam', 'Padang', 103),
(166044, 'Eddo Yulianda', 'Laki-laki', 'Padang', '1998-02-13', 'Islam', 'Padang', 103),
(166045, 'Fajar Islamy', 'Laki-laki', 'Padang', '1998-02-14', 'Islam', 'Padang', 103),
(166046, 'Febri Yanto', 'Laki-laki', 'Padang', '1998-02-15', 'Islam', 'Padang', 103),
(166047, 'Idil Firmansyah', 'Laki-laki', 'Padang', '1998-02-16', 'Islam', 'Padang', 103),
(166048, 'Ilham Wahyudi', 'Laki-laki', 'Padang', '1998-02-17', 'Islam', 'Padang', 103),
(166049, 'Irwan Fauzi', 'Laki-laki', 'Padang', '1998-02-18', 'Islam', 'Padang', 103),
(166050, 'Leo Agista', 'Laki-laki', 'Padang', '1998-02-19', 'Islam', 'Padang', 103),
(166051, 'Muhammad Azril', 'Laki-laki', 'Padang', '1998-02-20', 'Islam', 'Padang', 103),
(166052, 'Muhammad Ilham', 'Laki-laki', 'Padang', '1998-02-21', 'Islam', 'Padang', 103),
(166053, 'Muhammad Shidiq', 'Laki-laki', 'Padang', '1998-02-22', 'Islam', 'Padang', 103),
(166054, 'Nailah Azizah', 'Perempuan', 'Padang', '1998-02-23', 'Islam', 'Padang', 103),
(166055, 'Putri Ayuni', 'Perempuan', 'Padang', '1998-02-24', 'Islam', 'Padang', 103),
(166056, 'Rafki Arli', 'Laki-laki', 'Padang', '1998-02-25', 'Islam', 'Padang', 103),
(166057, 'Rina Oktavia', 'Perempuan', 'Padang', '1998-02-26', 'Islam', 'Padang', 103),
(166058, 'Riski Ananda', 'Laki-laki', 'Padang', '1998-02-27', 'Islam', 'Padang', 103),
(166059, 'Rivo Agusril', 'Laki-laki', 'Padang', '1998-02-28', 'Islam', 'Padang', 103),
(166060, 'Saputra Echo Prima.S', 'Laki-laki', 'Padang', '1998-03-01', 'Islam', 'Padang', 103),
(166061, 'Serlin Hidayatullah', 'Laki-laki', 'Padang', '1998-03-02', 'Islam', 'Padang', 103),
(166062, 'Wahyu Priagung', 'Laki-laki', 'Padang', '1998-03-03', 'Islam', 'Padang', 103),
(166063, 'Yurliamin Bunawolo', 'Laki-laki', 'Padang', '1998-03-04', 'Islam', 'Padang', 103),
(166064, 'Abdlu Hanafi', 'Laki-laki', 'Padang', '1998-03-05', 'Islam', 'Padang', 104),
(166065, 'Abi Muliya', 'Laki-laki', 'Padang', '1998-03-06', 'Islam', 'Padang', 104),
(166066, 'Andre Adha', 'Laki-laki', 'Padang', '1998-03-07', 'Islam', 'Padang', 104),
(166067, 'Arrahman Patria', 'Laki-laki', 'Padang', '1998-03-08', 'Islam', 'Padang', 104),
(166068, 'Bima Rizaldi Putra', 'Laki-laki', 'Padang', '1998-03-09', 'Islam', 'Padang', 104),
(166069, 'Dani Kumala Sakti', 'Laki-laki', 'Padang', '1998-03-10', 'Islam', 'Padang', 104),
(166070, 'Fachrul Rahman', 'Laki-laki', 'Padang', '1998-03-11', 'Islam', 'Padang', 104),
(166071, 'Fadhli Andrian', 'Laki-laki', 'Padang', '1998-03-12', 'Islam', 'Padang', 104),
(166072, 'Fikri Arinanta', 'Laki-laki', 'Padang', '1998-03-13', 'Islam', 'Padang', 104),
(166073, 'Ichsan Anugrah Pratama', 'Laki-laki', 'Padang', '1998-03-14', 'Islam', 'Padang', 104),
(166074, 'Irvan Dwi Saputra', 'Laki-laki', 'Padang', '1998-03-15', 'Islam', 'Padang', 104),
(166075, 'Jamal Saputra', 'Laki-laki', 'Padang', '1998-03-16', 'Islam', 'Padang', 104),
(166076, 'M. Herman Dani', 'Laki-laki', 'Padang', '1998-03-17', 'Islam', 'Padang', 104),
(166077, 'Medio Ramadhan Warisman', 'Laki-laki', 'Padang', '1998-03-18', 'Islam', 'Padang', 104),
(166078, 'Muh. Viko Agus Surnadi', 'Laki-laki', 'Padang', '1998-03-19', 'Islam', 'Padang', 104),
(166079, 'Muhammad Ilham', 'Laki-laki', 'Padang', '1998-03-20', 'Islam', 'Padang', 104),
(166080, 'Muhammad Rezi', 'Laki-laki', 'Padang', '1998-03-21', 'Islam', 'Padang', 104),
(166081, 'Qadritul Ramadhan', 'Laki-laki', 'Padang', '1998-03-22', 'Islam', 'Padang', 104),
(166082, 'Rahmad Vicra Ardi', 'Laki-laki', 'Padang', '1998-03-23', 'Islam', 'Padang', 104),
(166083, 'Ramdhan Farhanul Hakim', 'Laki-laki', 'Padang', '1998-03-24', 'Islam', 'Padang', 104),
(166084, 'Ridho Arrazaq', 'Laki-laki', 'Padang', '1998-03-25', 'Islam', 'Padang', 104),
(166085, 'Sariman Gustari', 'Laki-laki', 'Padang', '1998-03-26', 'Islam', 'Padang', 104),
(166086, 'Taofik Rahmat', 'Laki-laki', 'Padang', '1998-03-27', 'Islam', 'Padang', 104),
(166087, 'Rizki Alreza', 'Laki-laki', 'Padang', '1998-03-28', 'Islam', 'Padang', 104),
(166088, 'Abdul Rahman Hakim', 'Laki-laki', 'Padang', '1998-03-29', 'Islam', 'Padang', 105),
(166089, 'Akbar Za''Im Wahid', 'Laki-laki', 'Padang', '1998-03-30', 'Islam', 'Padang', 105),
(166090, 'Ardhimitra', 'Laki-laki', 'Padang', '1998-03-31', 'Islam', 'Padang', 105),
(166091, 'Auliya Alif Muhammad', 'Laki-laki', 'Padang', '1998-04-01', 'Islam', 'Padang', 105),
(166092, 'Budiman', 'Laki-laki', 'Padang', '1998-04-02', 'Islam', 'Padang', 105),
(166093, 'Dandy Pradana Putra', 'Laki-laki', 'Padang', '1998-04-03', 'Islam', 'Padang', 105),
(166094, 'Fajar Tri Maryadi', 'Laki-laki', 'Padang', '1998-04-04', 'Islam', 'Padang', 105),
(166095, 'Hafid Dimas Syukriadi', 'Laki-laki', 'Padang', '1998-04-05', 'Islam', 'Padang', 105),
(166096, 'Indrajid Haris Sadewo', 'Laki-laki', 'Padang', '1998-04-06', 'Islam', 'Padang', 105),
(166097, 'Ivan Benri Hutapea', 'Laki-laki', 'Padang', '1998-04-07', 'Islam', 'Padang', 105),
(166098, 'Khairul Tamimi', 'Laki-laki', 'Padang', '1998-04-08', 'Islam', 'Padang', 105),
(166099, 'M. Sulaiman', 'Laki-laki', 'Padang', '1998-04-09', 'Islam', 'Padang', 105),
(166100, 'Mohammad Nur Alif', 'Laki-laki', 'Padang', '1998-04-10', 'Islam', 'Padang', 105),
(166101, 'Muhammad Alfatah', 'Laki-laki', 'Padang', '1998-04-11', 'Islam', 'Padang', 105),
(166102, 'Muhammad Hardiansyah', 'Laki-laki', 'Padang', '1998-04-12', 'Islam', 'Padang', 105),
(166103, 'Muhammad Iqbal Maulana', 'Laki-laki', 'Padang', '1998-04-13', 'Islam', 'Padang', 105),
(166104, 'Rafi Ona Putra', 'Laki-laki', 'Padang', '1998-04-14', 'Islam', 'Padang', 105),
(166105, 'Raihan Habib', 'Laki-laki', 'Padang', '1998-04-15', 'Islam', 'Padang', 105),
(166106, 'Rais Daul Fadril', 'Laki-laki', 'Padang', '1998-04-16', 'Islam', 'Padang', 105),
(166107, 'Rangga Adi Prasetyo', 'Laki-laki', 'Padang', '1998-04-17', 'Islam', 'Padang', 105),
(166108, 'Riski Saputra', 'Laki-laki', 'Padang', '1998-04-18', 'Islam', 'Padang', 105),
(166109, 'Syukri Sujiono', 'Laki-laki', 'Padang', '1998-04-19', 'Islam', 'Padang', 105),
(166110, 'Trisno Nuriyanto', 'Laki-laki', 'Padang', '1998-04-20', 'Islam', 'Padang', 105),
(166111, 'Yogi Suherman', 'Laki-laki', 'Padang', '1998-04-21', 'Islam', 'Padang', 105),
(166112, 'Yopi Andika Saputra', 'Laki-laki', 'Padang', '1998-04-22', 'Islam', 'Padang', 105),
(166113, 'Yori Robeski', 'Laki-laki', 'Padang', '1998-04-23', 'Islam', 'Padang', 105),
(166114, 'Yuda Cahya', 'Laki-laki', 'Padang', '1998-04-24', 'Islam', 'Padang', 105),
(166115, 'Zatra Zufpril Yulianda', 'Laki-laki', 'Padang', '1998-04-25', 'Islam', 'Padang', 105),
(166116, 'Ahmad Fadli', 'Laki-laki', 'Padang', '1998-04-26', 'Islam', 'Padang', 106),
(166117, 'Aldo Jandres Saputra', 'Laki-laki', 'Padang', '1998-04-27', 'Islam', 'Padang', 106),
(166118, 'Ali Rudia', 'Laki-laki', 'Padang', '1998-04-28', 'Islam', 'Padang', 106),
(166119, 'Andilco Guslin Daeli', 'Laki-laki', 'Padang', '1998-04-29', 'Islam', 'Padang', 106),
(166120, 'Aulia Rahman', 'Laki-laki', 'Padang', '1998-04-30', 'Islam', 'Padang', 106),
(166121, 'Dafit Mansyah Putra', 'Laki-laki', 'Padang', '1998-05-01', 'Islam', 'Padang', 106),
(166122, 'Deri Darma Saputra', 'Laki-laki', 'Padang', '1998-05-02', 'Islam', 'Padang', 106),
(166123, 'Diky Wahyudi', 'Laki-laki', 'Padang', '1998-05-03', 'Islam', 'Padang', 106),
(166124, 'Harry Permana', 'Laki-laki', 'Padang', '1998-05-04', 'Islam', 'Padang', 106),
(166125, 'Husnul Fikri', 'Laki-laki', 'Padang', '1998-05-05', 'Islam', 'Padang', 106),
(166126, 'Ilham Praseptyo', 'Laki-laki', 'Padang', '1998-05-06', 'Islam', 'Padang', 106),
(166127, 'Jaka Ramadhan', 'Laki-laki', 'Padang', '1998-05-07', 'Islam', 'Padang', 106),
(166128, 'Jery', 'Laki-laki', 'Padang', '1998-05-08', 'Islam', 'Padang', 106),
(166129, 'Leonda Dicaprio', 'Laki-laki', 'Padang', '1998-05-09', 'Islam', 'Padang', 106),
(166130, 'Muhammad Tawakal', 'Laki-laki', 'Padang', '1998-05-10', 'Islam', 'Padang', 106),
(166131, 'Putra Nurman', 'Perempuan', 'Padang', '1998-05-11', 'Islam', 'Padang', 106),
(166132, 'Rahmat Syaputra', 'Laki-laki', 'Padang', '1998-05-12', 'Islam', 'Padang', 106),
(166133, 'Restu Maulana', 'Laki-laki', 'Padang', '1998-05-13', 'Islam', 'Padang', 106),
(166134, 'Romi Revanda', 'Laki-laki', 'Padang', '1998-05-14', 'Islam', 'Padang', 106),
(166135, 'Ryan Harianto', 'Laki-laki', 'Padang', '1998-05-15', 'Islam', 'Padang', 106),
(166136, 'Syahdan Maulana', 'Laki-laki', 'Padang', '1998-05-16', 'Islam', 'Padang', 106),
(166137, 'Yogi Irawan', 'Laki-laki', 'Padang', '1998-05-17', 'Islam', 'Padang', 106),
(166138, 'Al-Aziz', 'Laki-laki', 'Padang', '1998-05-18', 'Islam', 'Padang', 107),
(166139, 'Alfi Hamzah', 'Laki-laki', 'Padang', '1998-05-19', 'Islam', 'Padang', 107),
(166140, 'Algi Septian', 'Laki-laki', 'Padang', '1998-05-20', 'Islam', 'Padang', 107),
(166141, 'Andhika Habibie Putra', 'Laki-laki', 'Padang', '1998-05-21', 'Islam', 'Padang', 107),
(166142, 'Arnol Andika Pratama M', 'Laki-laki', 'Padang', '1998-05-22', 'Islam', 'Padang', 107),
(166143, 'Bayu Lorenzo', 'Laki-laki', 'Padang', '1998-05-23', 'Islam', 'Padang', 107),
(166144, 'Dean Putra Andika', 'Laki-laki', 'Padang', '1998-05-24', 'Islam', 'Padang', 107),
(166145, 'Dian Sukma Nugraha', 'Laki-laki', 'Padang', '1998-05-25', 'Islam', 'Padang', 107),
(166146, 'Doni Prima Putra', 'Laki-laki', 'Padang', '1998-05-26', 'Islam', 'Padang', 107),
(166147, 'Fajrul Rizkhi', 'Laki-laki', 'Padang', '1998-05-27', 'Islam', 'Padang', 107),
(166148, 'Heru Purwanto', 'Laki-laki', 'Padang', '1998-05-28', 'Islam', 'Padang', 107),
(166149, 'Ilham Fadila', 'Laki-laki', 'Padang', '1998-05-29', 'Islam', 'Padang', 107),
(166150, 'Jefri Kurnia', 'Laki-laki', 'Padang', '1998-05-30', 'Islam', 'Padang', 107),
(166151, 'Kreshna Gari', 'Laki-laki', 'Padang', '1998-05-31', 'Islam', 'Padang', 107),
(166152, 'Rado Anansia', 'Laki-laki', 'Padang', '1998-06-01', 'Islam', 'Padang', 107),
(166153, 'Raja Alva Zona', 'Laki-laki', 'Padang', '1998-06-02', 'Islam', 'Padang', 107),
(166154, 'Redo Syaiful Rahmat', 'Laki-laki', 'Padang', '1998-06-03', 'Islam', 'Padang', 107),
(166155, 'Ridho Febrian Syani ', 'Laki-laki', 'Padang', '1998-06-04', 'Islam', 'Padang', 107),
(166156, 'Robby Satria', 'Laki-laki', 'Padang', '1998-06-05', 'Islam', 'Padang', 107),
(166157, 'Rovio Nofril Effendi', 'Laki-laki', 'Padang', '1998-06-06', 'Islam', 'Padang', 107),
(166158, 'Vicram Sakubou', 'Laki-laki', 'Padang', '1998-06-07', 'Islam', 'Padang', 107),
(166159, 'Zikrullah', 'Laki-laki', 'Padang', '1998-06-08', 'Islam', 'Padang', 107),
(166160, 'Danang Saputra', 'Laki-laki', 'Padang', '1998-06-09', 'Islam', 'Padang', 107),
(166161, 'Muhammad Fariq', 'Laki-laki', 'Padang', '1998-06-10', 'Islam', 'Padang', 107),
(166162, 'Muhammad Septio', 'Laki-laki', 'Padang', '1998-06-11', 'Islam', 'Padang', 107);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_walas`
--

CREATE TABLE `tb_walas` (
  `KodeWls` int(3) NOT NULL,
  `NamaWls` varchar(25) NOT NULL,
  `KodeKls` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `inbox`
--
ALTER TABLE `inbox`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `outbox`
--
ALTER TABLE `outbox`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `outbox_date` (`SendingDateTime`,`SendingTimeOut`),
  ADD KEY `outbox_sender` (`SenderID`);

--
-- Indexes for table `outbox_multipart`
--
ALTER TABLE `outbox_multipart`
  ADD PRIMARY KEY (`ID`,`SequencePosition`);

--
-- Indexes for table `pbk`
--
ALTER TABLE `pbk`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `pbk_groups`
--
ALTER TABLE `pbk_groups`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `phones`
--
ALTER TABLE `phones`
  ADD PRIMARY KEY (`IMEI`);

--
-- Indexes for table `sentitems`
--
ALTER TABLE `sentitems`
  ADD PRIMARY KEY (`ID`,`SequencePosition`),
  ADD KEY `sentitems_date` (`DeliveryDateTime`),
  ADD KEY `sentitems_tpmr` (`TPMR`),
  ADD KEY `sentitems_dest` (`DestinationNumber`),
  ADD KEY `sentitems_sender` (`SenderID`);

--
-- Indexes for table `tb_absen`
--
ALTER TABLE `tb_absen`
  ADD PRIMARY KEY (`KodeAbsen`),
  ADD KEY `NomorIndukSiswa` (`NIS`);

--
-- Indexes for table `tb_jurusan`
--
ALTER TABLE `tb_jurusan`
  ADD PRIMARY KEY (`KodeJrs`);

--
-- Indexes for table `tb_kelas`
--
ALTER TABLE `tb_kelas`
  ADD PRIMARY KEY (`KodeKls`);

--
-- Indexes for table `tb_petugas`
--
ALTER TABLE `tb_petugas`
  ADD PRIMARY KEY (`NamaPtg`);

--
-- Indexes for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  ADD PRIMARY KEY (`NIS`);

--
-- Indexes for table `tb_walas`
--
ALTER TABLE `tb_walas`
  ADD PRIMARY KEY (`KodeWls`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `inbox`
--
ALTER TABLE `inbox`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `outbox`
--
ALTER TABLE `outbox`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pbk`
--
ALTER TABLE `pbk`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pbk_groups`
--
ALTER TABLE `pbk_groups`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tb_absen`
--
ALTER TABLE `tb_absen`
  MODIFY `KodeAbsen` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
