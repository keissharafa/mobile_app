import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/features/dosen/data/models/dosen_model.dart';
import 'package:flutter_application_1/features/dosen/presentation/providers/dosen_provider.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);
    final savedUsers = ref.watch(savedUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(dosenNotifierProvider),
          ),
        ],
      ),

      /// ✅ FIX SCROLL
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ================= SAVED USER =================
            _SavedUserSection(savedUsers: savedUsers, ref: ref),

            /// ================= TITLE =================
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                "Daftar Dosen",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),

            /// ================= LIST DOSEN =================
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: dosenState.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),

                error: (error, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Gagal memuat data: ${error.toString()}"),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(dosenNotifierProvider.notifier)
                            .refresh(),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),

                data: (dosenList) => ListView.builder(
                  itemCount: dosenList.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final dosen = dosenList[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading:
                            CircleAvatar(child: Text('${dosen.id}')),
                        title: Text(dosen.name),
                        subtitle: Text(dosen.email),

                        trailing: IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: () async {
                            await ref
                                .read(dosenNotifierProvider.notifier)
                                .saveSelectedDosen(dosen);

                            ref.invalidate(savedUsersProvider);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${dosen.name} disimpan'),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






// ================= SAVED USER SECTION =================

class _SavedUserSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  final WidgetRef ref;

  const _SavedUserSection({
    required this.savedUsers,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER
          Row(
            children: [
              const Icon(Icons.storage),
              const SizedBox(width: 6),
              const Text(
                "Data Tersimpan di Local Storage",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),

              /// tombol hapus semua
              savedUsers.when(
                data: (users) => users.isNotEmpty
                    ? TextButton(
                        onPressed: () async {
                          await ref
                              .read(dosenNotifierProvider.notifier)
                              .clearSavedUsers();

                          ref.invalidate(savedUsersProvider);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Semua data dihapus")),
                            );
                          }
                        },
                        child: const Text("Hapus Semua"),
                      )
                    : const SizedBox(),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// CONTENT
          savedUsers.when(
            loading: () => const CircularProgressIndicator(),

            error: (_, __) =>
                const Text("Gagal membaca data tersimpan"),

            data: (users) {
              if (users.isEmpty) {
                return const Text("Belum ada data tersimpan");
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                separatorBuilder: (_, __) => const Divider(),

                itemBuilder: (context, index) {
                  final user = users[index];

                  return ListTile(
                    dense: true,
                    title: Text(user['username'] ?? '-'),

                    /// ✅ FIX: tampil ID + tanggal
                    subtitle: Text(
                      "ID: ${user['user_id']} • ${_formatDate(user['saved_at'] ?? '')}",
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () async {
                        await ref
                            .read(dosenNotifierProvider.notifier)
                            .removeSavedUser(user['user_id'] ?? '');

                        ref.invalidate(savedUsersProvider);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}





// ================= FORMAT DATE =================

String _formatDate(String isoString) {
  if (isoString.isEmpty) return '-';
  try {
    final date = DateTime.parse(isoString);
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  } catch (e) {
    return isoString;
  }
}