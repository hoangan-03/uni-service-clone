// import 'package:flutter/material.dart';
// import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
// import 'package:flutter_base_v2/features/home/presentation/views/menu/menu.dart';
// import 'package:flutter_base_v2/utils/config/app_text_style.dart';
// import 'package:flutter_base_v2/utils/config/app_theme.dart';

// Widget buildSectionHeader(String title, String actionText, BuildContext context, List<MenuItem> menuItems) {
//   final appColors = Theme.of(context).extension<AppColors>();
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         title,
//         style: AppTextStyle.bold18(), 
//       ),
//       GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => MenuPage(title: title, menuItems: menuItems),
//             ),
//           );
//         },
//         child: Row(
//           children: [
//             Text(
//               actionText,
//               style: AppTextStyle.regular16().copyWith(color: appColors?.primary),
//             ),
//             Icon(
//               Icons.chevron_right,
//               color: appColors?.primary,
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }