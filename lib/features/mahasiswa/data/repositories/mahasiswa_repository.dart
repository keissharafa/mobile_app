import 'package:dio/dio.dart';

import '../models/mahasiswa_model.dart';

class MahasiswaRepository {

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

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/comments',
      );

      print("STATUS MAHASISWA: ${response.statusCode}");

      final List<dynamic> data = response.data;

      return data
          .map((json) => MahasiswaModel.fromJson(json))
          .toList();

    } catch (e) {
      print("Error: $e");
      throw Exception('Gagal memuat data mahasiswa aktif');;
    }
  }
}