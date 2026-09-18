import 'package:flutter/material.dart';

class ProfileStat {
  final String value;
  final String label;

  const ProfileStat({required this.value, required this.label});
}

class ProfileStatsRow extends StatelessWidget {
  final List<ProfileStat> stats;

  const ProfileStatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < stats.length; i++) {
      children.add(Expanded(child: _StatItem(stat: stats[i])));
      if (i != stats.length - 1) {
        children.add(
          Container(
            width: 1,
            height: 36,
            color: Colors.grey.shade300,
          ),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: children),
    );
  }
}

class _StatItem extends StatelessWidget {
  final ProfileStat stat;

  const _StatItem({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          stat.value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          stat.label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}