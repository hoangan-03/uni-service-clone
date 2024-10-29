import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/item_card.dart';

Widget buildItemList(List<MenuItem> items, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: buildItemCard(item, context),
                ))
            .toList(),
      ),
    );
  }
// import 'package:flutter/material.dart';
// import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
// import 'package:get/get.dart';
// import 'package:flutter_base_v2/utils/config/app_text_style.dart';

// Widget buildItemList(BuildContext context, String branchId, String category) {
//   return Scaffold(
//     body: Center(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 32.0),
//             Text(
//               'Chọn món ăn',
//               style: AppTextStyle.bold20(),
//             ),
//             const SizedBox(height: 16.0),
//             Expanded(
//               child: Obx(() {
//                 if (controller.menus.isEmpty) {
//                   controller.getMenus(branchId, category);
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 return Expanded(
//                   child: controller.getMenusState.widget(
//                     onLoading: const Center(child: CircularProgressIndicator()),
//                     onSuccess: (menus) {
//                       return ListView.builder(
//                         itemCount: menus?.length ?? 0,
//                         itemBuilder: (context, index) {
//                           final menu = menus![index];
//                           return Obx(() {
//                             return Column(
//                               children: menu.items.map((item) {
//                                 return ListTile(
//                                   title: Text(item.name),
//                                   subtitle: item.description.isNotEmpty == true
//                                       ? Text(
//                                           item.description,
//                                           style: AppTextStyle.regular12()
//                                               .copyWith(color: Colors.green),
//                                         )
//                                       : null,
//                                 );
//                               }).toList(),
//                             );
//                           });
//                         },
//                       );
//                     },
//                     onError: (error) => Center(child: Text('Error: $error')),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
