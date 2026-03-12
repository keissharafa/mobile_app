import 'package:flutter/material.dart';

import '../../data/models/dosen_model.dart';

class ModernDosenCard extends StatefulWidget {
  final DosenModel dosen;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const ModernDosenCard({
    super.key,
    required this.dosen,
    this.onTap,
    this.gradientColors,
  });

  @override
  State<ModernDosenCard> createState() => _ModernDosenCardState();
}

class _ModernDosenCardState extends State<ModernDosenCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final gradientColors = widget.gradientColors ??
        [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.7),
        ];

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),

      child: ScaleTransition(
        scale: _scaleAnimation,

        child: Container(
          margin: const EdgeInsets.only(bottom: 16),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, gradientColors[0].withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
            border: Border.all(
              color: gradientColors[0].withOpacity(0.1),
              width: 1,
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
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Center(
                    child: Text(
                      widget.dosen.nama.substring(0,1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /// Info dosen
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        widget.dosen.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      _buildInfoRow(
                        Icons.badge_outlined,
                        "NIP: ${widget.dosen.nip}",
                      ),

                      const SizedBox(height: 4),

                      _buildInfoRow(
                        Icons.email_outlined,
                        widget.dosen.email,
                      ),

                      const SizedBox(height: 4),

                      _buildInfoRow(
                        Icons.school_outlined,
                        widget.dosen.jurusan,
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.arrow_forward_ios_rounded,size:16)

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [

        Icon(icon, size: 14, color: Colors.grey[600]),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}






/// ================================
/// LIST VIEW DOSEN
/// ================================

class DosenListView extends StatelessWidget {

  final List<DosenModel> dosenList;
  final VoidCallback? onRefresh;
  final bool useModernCard;

  const DosenListView({
    super.key,
    required this.dosenList,
    this.onRefresh,
    this.useModernCard = true,
  });

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh?.call();
      },

      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dosenList.length,

        itemBuilder: (context, index) {

          final dosen = dosenList[index];

          final gradients = [
    [Colors.purple, Colors.deepPurple],
    [Colors.pink, Colors.orange],
    [Colors.blue, Colors.cyan],
  ];

          if (useModernCard) {
            return ModernDosenCard(
              dosen: dosen,
              gradientColors: gradients[index % gradients.length],
            );
          }

          return Card(
            child: ListTile(
              title: Text(dosen.nama),
              subtitle: Text(dosen.email),
              trailing: Text(dosen.nip),
            ),
          );
        },
      ),
    );
  }
}