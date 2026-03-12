import 'dart:io';

void main() {
  // Membuat Set dengan data awal
  Set<String> burung = {'Merpati', 'Elang', 'Kakatua'};
  print('Burung awal: $burung');

  // Tambah data
  burung.add('Cendrawasih');
  print('\nSetelah tambah data: $burung');

  // Tambah data duplicate
  burung.add('Elang'); // Duplicate
  print('Setelah tambah duplicate (Elang): $burung');

  // Hapus data
  burung.remove('Kakatua');
  print('Setelah hapus Kakatua: $burung');

  // Cek data tertentu
  if (burung.contains('Elang')) {
    print('Elang ada di dalam Set');
  } else {
    print('Elang tidak ada di dalam Set');
  }

  // Hitung jumlah data
  print('Jumlah data dalam Set: ${burung.length}');

  // ===============================
  // Versi Input 
  // ===============================

// Tampilkan semua data (awal)
print('\n=== SEMUA DATA ===');
int no = 1;
for (String item in burung) {
  print('$no. $item');
  no++;
}

print('Total data: ${burung.length}');

// Tambah data baru
stdout.write('Masukkan data baru: ');
String dataBaru = stdin.readLineSync()!;
burung.add(dataBaru);
print('Data "$dataBaru" berhasil ditambahkan!');

// Hapus data
stdout.write('Masukkan data yang ingin dihapus: ');
String hapusData = stdin.readLineSync()!;
if (burung.remove(hapusData)) {
  print('Data "$hapusData" berhasil dihapus!');
} else {
  print('Data "$hapusData" tidak ada di Set!');
}

// Cek data
stdout.write('Masukkan data yang ingin dicek: ');
String cekData = stdin.readLineSync()!;
if (burung.contains(cekData)) {
  print('Data "$cekData" ada di Set!');
} else {
  print('Data "$cekData" tidak ada di Set!');
}
}