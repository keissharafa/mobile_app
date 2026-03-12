import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/common_widgets.dart';
import '../../../mahasiswa/data/models/mahasiswa_model.dart';
import '../../../mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final mahasiswaAktif = [
      MahasiswaModel(
        nama: "Budi Santoso",
        nim: "2101001",
        email: "budi@example.com",
        jurusan: "Teknik Informatika",
      ),
      MahasiswaModel(
        nama: "Siti Rahma",
        nim: "2101002",
        email: "siti@example.com",
        jurusan: "Teknik Informatika",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mahasiswa Aktif"),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),

      body: MahasiswaListView(
        mahasiswaList: mahasiswaAktif,
      ),
    );
  }
}