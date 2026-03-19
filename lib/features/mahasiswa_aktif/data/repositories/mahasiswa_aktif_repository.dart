import 'package:dio/dio.dart';

import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {

  final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'Accept': 'application/json',
        'User-Agent': 'Mozilla/5.0',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );

      print("STATUS MAHASISWA AKTIF: ${response.statusCode}");

      final List<dynamic> data = response.data;

      return data
          .map((json) => MahasiswaAktifModel.fromJson(json))
          .toList();

    } catch (e) {
      print("Error: $e");
      throw Exception('Gagal memuat data mahasiswa aktif');
    }
  }
}