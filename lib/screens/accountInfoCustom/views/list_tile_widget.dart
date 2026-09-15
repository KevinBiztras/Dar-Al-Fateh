import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback? onTap;

  const CustomListTileCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(image, width: 40, height: 40),
        title: Text(title, style: TextStyle(color: AppColors.black)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
