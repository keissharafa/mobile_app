import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {

    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaAktifModel(
        nama: 'Budi Santoso',
        nim: '220001',
        email: 'budi@example.com',
        jurusan: 'Teknik Informatika',
        status: 'Aktif',
      ),

      MahasiswaAktifModel(
        nama: 'Siti Rahma',
        nim: '220002',
        email: 'siti@example.com',
        jurusan: 'Teknik Informatika',
        status: 'Aktif',
      ),

      MahasiswaAktifModel(
        nama: 'Andi Pratama',
        nim: '220003',
        email: 'andi@example.com',
        jurusan: 'Teknik Informatika',
        status: 'Aktif',
      ),
    ];
  }
}