import 'package:dio/dio.dart';

import '../models/dosen_model.dart';

class DosenRepository {

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

  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );

      print("STATUS DOSEN: ${response.statusCode}");

      final List<dynamic> data = response.data;

      return data
          .map((json) => DosenModel.fromJson(json))
          .toList();

    } catch (e) {
      print("Error: $e");
      throw Exception('Gagal memuat data mahasiswa aktif');
    }
  }
}