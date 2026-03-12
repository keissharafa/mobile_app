import 'dart:io';

// =====================================================
//  PARENT CLASS
// =====================================================
class Mahasiswa {
  String nama;
  int nim;
  String jurusan;

  Mahasiswa(this.nama, this.nim, this.jurusan);

  void tampilkanData() {
    print("\n=== DATA MAHASISWA ===");
    print("Nama    : $nama");
    print("NIM     : $nim");
    print("Jurusan : $jurusan");
  }
}

// =====================================================
//  EXTENDS (INHERITANCE)
// =====================================================

// ---- Mahasiswa Aktif ----
class MahasiswaAktif extends Mahasiswa {
  int semester;

  MahasiswaAktif(
    String nama,
    int nim,
    String jurusan,
    this.semester,
  ) : super(nama, nim, jurusan);

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Status   : Mahasiswa Aktif");
    print("Semester : $semester");
  }
}

// ---- Mahasiswa Alumni ----
class MahasiswaAlumni extends Mahasiswa {
  int tahunLulus;

  MahasiswaAlumni(
    String nama,
    int nim,
    String jurusan,
    this.tahunLulus,
  ) : super(nama, nim, jurusan);

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Status       : Alumni");
    print("Tahun Lulus  : $tahunLulus");
  }
}

// =====================================================
//  MIXIN
// =====================================================

mixin BisaLogin {
  void login() {
    print("Login berhasil.");
  }
}

mixin BisaAbsen {
  void absen() {
    print("Absen berhasil dicatat.");
  }
}

mixin BisaCetakKartu {
  void cetakKartu() {
    print("Kartu berhasil dicetak.");
  }
}

// =====================================================
//  DOSEN (extends + mixin)
// =====================================================

class Dosen extends Mahasiswa
    with BisaLogin, BisaAbsen, BisaCetakKartu {

  String nip;
  String mataKuliah;

  Dosen(
    String nama,
    int nim,
    String jurusan,
    this.nip,
    this.mataKuliah,
  ) : super(nama, nim, jurusan);

  @override
  void tampilkanData() {
    print("\n=== DATA DOSEN ===");
    print("Nama        : $nama");
    print("NIP         : $nip");
    print("Jurusan     : $jurusan");
    print("Mata Kuliah : $mataKuliah");
  }
}

// =====================================================
//  FAKULTAS (extends + mixin)
// =====================================================

class Fakultas extends Mahasiswa
    with BisaLogin, BisaAbsen, BisaCetakKartu {

  String namaFakultas;

  Fakultas(
    String nama,
    int nim,
    String jurusan,
    this.namaFakultas,
  ) : super(nama, nim, jurusan);

  @override
  void tampilkanData() {
    print("\n=== DATA FAKULTAS ===");
    print("Nama         : $nama");
    print("Jurusan      : $jurusan");
    print("Fakultas     : $namaFakultas");
  }
}

// =====================================================
//  MAIN (OBJECT)
// =====================================================

void main() {
  // Mahasiswa Aktif
  MahasiswaAktif aktif =
      MahasiswaAktif("Keisha", 22001, "Informatika", 4);
  aktif.tampilkanData();

  // Mahasiswa Alumni
  MahasiswaAlumni alumni =
      MahasiswaAlumni("Radin", 18001, "Informatika", 2023);
  alumni.tampilkanData();

  // Dosen
  Dosen dosen =
      Dosen("Pak Anang", 0, "Informatika", "1987654321", "Pemrograman Mobile");
  dosen.tampilkanData();
  dosen.login();
  dosen.absen();
  dosen.cetakKartu();

  // Fakultas
  Fakultas fakultas =
      Fakultas("Admin Fakultas", 0, "Teknik", "Fakultas Teknik");
  fakultas.tampilkanData();
  fakultas.login();
  fakultas.absen();
  fakultas.cetakKartu();
}