import 'dart:io';

void main() {
  List<String> names = ['Alice', 'Bob', 'Charlie'];
  print('Names: $names');

  // tambah data list
  names.add('Delta');
  print('Names setelah ditambahkan: $names');

  // mengambil data index tertentu
  print('Nama pada index 0: ${names[0]}');
  print('Nama pada index 1: ${names[1]}');

  // mengubah data index tertentu
  names[1] = 'Bravo';
  print('Names setelah diubah: $names');

  // menghapus data
  names.remove('Charlie');
  print('Names setelah dihapus: $names');

  // menghitung jumlah data
  print('Jumlah data dalam list: ${names.length}');

  // looping
  print('Menampilkan setiap elemen:');
  for (String name in names) {
    print(name);
  }

// Membuat list kosong
List<String> dataList = [];
print('Data list kosong: $dataList');

// Mengambil jumlah data dari pengguna
int count = 0;
while (count <= 0) {
  stdout.write('Masukkan jumlah list: ');
  String? input = stdin.readLineSync();
  try {
    count = int.parse(input!);
    if (count <= 0) {
      print('Masukkan angka lebih dari 0!');
    }
  } catch (e) {
    print('Input tidak valid! Masukkan angka yang benar.');
  }
}

// memasukkan data ke dalam list menggunakan for loop
for (int i = 0; i < count; i++) {
  stdout.write('data ke-${i + 1}: ');
  String x = stdin.readLineSync()!;
  dataList.add(x);
}

// Menampilkan data list
print('Data list:');
print(dataList);

// Tampil berdasarkan index tertentu
stdout.write('\nMasukkan index yang ingin ditampilkan: ');
int showIndex = int.parse(stdin.readLineSync()!);

if (showIndex >= 0 && showIndex < dataList.length) {
  print('Data pada index $showIndex: ${dataList[showIndex]}');
} else {
  print('Index tidak valid!');
}

// Ubah berdasarkan index tertentu
stdout.write('\nMasukkan index yang ingin diubah: ');
int editIndex = int.parse(stdin.readLineSync()!);

if (editIndex >= 0 && editIndex < dataList.length) {
  stdout.write('Masukkan data baru: ');
  String newValue = stdin.readLineSync()!;
  dataList[editIndex] = newValue;
  print('Data berhasil diubah!');
} else {
  print('Index tidak valid!');
}

// Hapus berdasarkan index tertentu
stdout.write('\nMasukkan index yang ingin dihapus: ');
int deleteIndex = int.parse(stdin.readLineSync()!);

if (deleteIndex >= 0 && deleteIndex < dataList.length) {
  dataList.removeAt(deleteIndex);
  print('Data berhasil dihapus!');
} else {
  print('Index tidak valid!');
}

// Tampilkan hasil akhir
print('\n=== SEMUA DATA ===');
for (int i = 0; i < dataList.length; i++) {
  print('Index $i: ${dataList[i]}');
}
}

