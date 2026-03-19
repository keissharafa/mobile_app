import 'package:flutter/material.dart';

import '../../data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifListView extends StatelessWidget {

  final List<MahasiswaAktifModel> mahasiswaList;
  final VoidCallback? onRefresh;

  const MahasiswaAktifListView({
    super.key,
    required this.mahasiswaList,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh?.call();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {

          final mahasiswa = mahasiswaList[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),

            child: ListTile(

              /// Avatar (pakai huruf pertama dari title)
              leading: CircleAvatar(
                child: Text(
                  mahasiswa.title.substring(0,1).toUpperCase(),
                ),
              ),

              /// Title
              title: Text(
                mahasiswa.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              /// Subtitle
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("User ID: ${mahasiswa.userId}"),
                  Text("Post ID: ${mahasiswa.id}"),

                  const SizedBox(height: 4),

                  Text(
                    mahasiswa.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}