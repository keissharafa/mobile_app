import '../models/mahasiswa_model.dart';

class MahasiswaRepository {

  Future<List<MahasiswaModel>> getMahasiswaList() async {

    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '220001',
        email: 'budi@example.com',
        jurusan: 'Teknik Informatika',
      ),

      MahasiswaModel(
        nama: 'Siti Rahma',
        nim: '220002',
        email: 'siti@example.com',
        jurusan: 'Teknik Informatika',
      ),

      MahasiswaModel(
        nama: 'Andi Pratama',
        nim: '220003',
        email: 'andi@example.com',
        jurusan: 'Teknik Informatika',
      ),
    ];
  }
}