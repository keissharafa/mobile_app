import 'dart:io';

void main() {
  // Membuat Map dengan data awal
  Map<String, String> data = {
    'Keisha': '081234567890',
    'Radin': '082345678901',
    'Kepin': '083456789012',
  };

  print('Data: $data');

  // Menambahkan data ke Map
  data['Arum'] = '084567890123';
  print('Data setelah ditambahkan: $data');

  // Mengakses data berdasarkan key
  print('Nomor Arum: ${data['Arum']}');

  // Ubah data berdasarkan key
  data['Keisha'] = '080000000000';
  print('\nSetelah ubah Keisha: $data');

  // Hapus data berdasarkan key
  data.remove('Radin');
  print('Setelah hapus Radin: $data');

  // Cek data berdasarkan key
  stdout.write('\nMasukkan nama yang ingin dicek: ');
  String cekNama = stdin.readLineSync()!;
  if (data.containsKey(cekNama)) {
    print('Data "$cekNama" ada dengan nomor ${data[cekNama]}');
  } else {
    print('Data "$cekNama" tidak ditemukan');
  }

  // Hitung jumlah data
  print('Jumlah data: ${data.length}');

  // Tampilkan semua key
  print('Semua key: ${data.keys}');

  // Tampilkan semua value
  print('Semua value: ${data.values}');

  // f. INPUT SINGLE MAHASISWA
  print('\n=== INPUT DATA MAHASISWA ===');

  stdout.write('Masukkan NIM: ');
  String nim = stdin.readLineSync()!;

  stdout.write('Masukkan Nama: ');
  String nama = stdin.readLineSync()!;

  stdout.write('Masukkan Jurusan: ');
  String jurusan = stdin.readLineSync()!;

  stdout.write('Masukkan IPK: ');
  String ipk = stdin.readLineSync()!;

  Map<String, dynamic> mahasiswa = {
    'nim': nim,
    'nama': nama,
    'jurusan': jurusan,
    'ipk': ipk,
  };

  print('\nData Mahasiswa: $mahasiswa');

  // INPUT MULTIPLE MAHASISWA
  print('\n=== INPUT MULTIPLE MAHASISWA ===');

  stdout.write('Masukkan jumlah mahasiswa: ');
  int jumlah = int.parse(stdin.readLineSync()!);

  List<Map<String, dynamic>> listMahasiswa = [];

  for (int i = 0; i < jumlah; i++) {
    print('\n--- Mahasiswa ke-${i + 1} ---');

    stdout.write('Masukkan NIM: ');
    String nimM = stdin.readLineSync()!;

    stdout.write('Masukkan Nama: ');
    String namaM = stdin.readLineSync()!;

    stdout.write('Masukkan Jurusan: ');
    String jurusanM = stdin.readLineSync()!;

    stdout.write('Masukkan IPK: ');
    String ipkM = stdin.readLineSync()!;

    listMahasiswa.add({
      'nim': nimM,
      'nama': namaM,
      'jurusan': jurusanM,
      'ipk': ipkM,
    });
  }

  print('\n=== DATA SEMUA MAHASISWA ===');
  for (var mhs in listMahasiswa) {
    print(mhs);
  }
}