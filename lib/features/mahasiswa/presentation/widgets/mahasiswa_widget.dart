import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:flutter_application_1/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';

class MahasiswaListView extends StatelessWidget {
  final List<MahasiswaModel> mahasiswaList;
  final VoidCallback? onRefresh;

  const MahasiswaListView({
    super.key,
    required this.mahasiswaList,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          final mahasiswa = mahasiswaList[index];

          final gradients = [
            [Colors.indigo, Colors.deepPurple],
            [Colors.pink, Colors.orange],
            [Colors.blue, Colors.cyan],
            [Colors.teal, Colors.green],
          ];

          return ModernMahasiswaCard(
            mahasiswa: mahasiswa,
            gradientColors: gradients[index % gradients.length],
          );
        },
      ),
    );
  }
}

// ================= CARD =================

class ModernMahasiswaCard extends ConsumerWidget {
  final MahasiswaModel mahasiswa;
  final List<Color>? gradientColors;

  const ModernMahasiswaCard({
    super.key,
    required this.mahasiswa,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = gradientColors ??
        [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.7),
        ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, colors[0].withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(
          color: colors[0].withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            /// Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  mahasiswa.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            /// Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mahasiswa.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(mahasiswa.email),

                  const SizedBox(height: 4),

                  Text(
                    mahasiswa.address.city,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            /// SAVE BUTTON 🔥
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                await ref
                    .read(mahasiswaNotifierProvider.notifier)
                    .saveSelectedMahasiswa(mahasiswa);

                ref.invalidate(savedMahasiswaProvider);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${mahasiswa.name} disimpan'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}