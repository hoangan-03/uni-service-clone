// import 'package:flutter/material.dart';
// import 'package:flutter_base_v2/base/domain/base_state.dart';
// import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
// import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
// import 'package:flutter_base_v2/features/home/presentation/widgets/item_card.dart';

// Widget buildItemList(List<MenuItem> items, BuildContext context, BaseState<List<Menu>?> state) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: items
//             .map((item) => Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: buildItemCard(item, context),
//                 ))
//             .toList(),
//       ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/item_card.dart';

Widget buildItemList(
    BuildContext context, String category, BaseState<List<Menu>?> state) {
  return SizedBox(
    child: state.widget(
      onLoading: const Center(child: CircularProgressIndicator()),
      onSuccess: (menusMap) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  category,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: menusMap!
                      .map((menu) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: buildItemCard(menu.product, context),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
      onError: (error) {
        print('Errorbug: $error');
        return Center(child: Text('Error: $error'));
      },
    ),
  );
}












// import 'package:flutter/material.dart';
// import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
// import 'package:get/get.dart';


// import 'package:flutter_base_v2/utils/config/app_text_style.dart';
// import 'package:get/get.dart';

// Widget buildItemList(
//     List<MenuItem> items, BuildContext context, BaseState<List<Menu>?> state) {
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
//                 return Expanded(
//                   child: state.widget(
//                     onLoading: const Center(child: CircularProgressIndicator()),
//                     onSuccess: (menus) {
//                       return ListView.builder(
//                         itemCount: menus?.length,
//                         itemBuilder: (context, index) {
//                           final menu = menus![index];
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ListTile(
//                                 title: Text(menu.product.name),
//                                 // subtitle: item.id != null && item.id!.isNotEmpty
//                                 //     ? Text(
//                                 //         item.id!,
//                                 //         style: AppTextStyle.regular12()
//                                 //             .copyWith(color: appColors?.gray),
//                                 //       )
//                                 //     : null,
//                               )
//                             ],
//                           );
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
