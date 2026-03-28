import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:flutter_application_1/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);
    final savedUsers = ref.watch(savedMahasiswaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Mahasiswa"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(mahasiswaNotifierProvider),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= SAVED =================
            _SavedMahasiswaSection(savedUsers: savedUsers, ref: ref),

            /// ================= TITLE =================
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Daftar Mahasiswa",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            /// ================= LIST =================
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: mahasiswaState.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text("Error: $e")),
                data: (list) => MahasiswaListView(
                  mahasiswaList: list,
                  onRefresh: () =>
                      ref.invalidate(mahasiswaNotifierProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= SAVED SECTION =================

class _SavedMahasiswaSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  final WidgetRef ref;

  const _SavedMahasiswaSection({
    required this.savedUsers,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: savedUsers.when(
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const Text("Error"),
        data: (users) {
          if (users.isEmpty) {
            return const Text("Belum ada data tersimpan");
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Data Tersimpan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      await ref
                          .read(mahasiswaNotifierProvider.notifier)
                          .clearSavedMahasiswa();

                      ref.invalidate(savedMahasiswaProvider);
                    },
                    child: const Text("Hapus Semua"),
                  )
                ],
              ),

              ...users.map((user) => ListTile(
                    title: Text(user['username'] ?? '-'),
                    subtitle: Text(
                        "ID: ${user['user_id']} • ${_formatDate(user['saved_at'] ?? '')}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () async {
                        await ref
                            .read(mahasiswaNotifierProvider.notifier)
                            .removeSavedMahasiswa(
                                user['user_id'] ?? '');

                        ref.invalidate(savedMahasiswaProvider);
                      },
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}

// ================= FORMAT DATE =================

String _formatDate(String iso) {
  try {
    final d = DateTime.parse(iso);
    return "${d.day}/${d.month}/${d.year} ${d.hour}:${d.minute}";
  } catch (e) {
    return iso;
  }
}