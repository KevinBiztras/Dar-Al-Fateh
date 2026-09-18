import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';


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


// import 'package:flutter/material.dart';
// import 'package:flutter_project_structure/constants/app_constants.dart';

// class CustomListTileCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Color iconBgColor;
//   final Color iconColor;
//   final VoidCallback? onTap;

//   const CustomListTileCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.iconBgColor,
//     required this.iconColor,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           child: Row(
//             children: [
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: iconBgColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(icon, color: iconColor, size: 22),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 12.5,
//                         color: Colors.grey.shade500,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(Icons.chevron_right, color: Colors.grey.shade400),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }