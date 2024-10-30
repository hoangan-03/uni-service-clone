import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
import 'package:flutter_base_v2/features/home/data/repositories/menu_mockdata.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/greetings.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/header.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/main_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/menu_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/top_nav_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageContent extends StatelessWidget {
  final String currentMenu;
  final String branchId;
  final String greeting = getGreeting();
  final String selectedCategory;
  final Function(String) onMenuSelected;
  final BaseState<Map<String, List<Menu>>?> state;
  // final HomeController controller;

  HomePageContent({
    super.key,
    required this.branchId,
    required this.currentMenu,
    required this.onMenuSelected, 
    required this.state, 
    required this.selectedCategory,

  });

  @override
  Widget build(BuildContext context) {
    final Map<String, List<MenuItem>> menuItems = {
      'Tất cả': [...todayMenuItems, ...tomorrowMenuItems],
      'Thực đơn chính': todayMenuItems,
      'Đồ uống': drinksMenuItems,
      'Food court': foodCourtMenuItems,
      'Đặc sản địa phương': localSpecialtiesMenuItems,
    };

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),
            const SizedBox(height: 16),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TopNavButton(
                        icon: FontAwesomeIcons.bellConcierge,
                        label: 'Tất cả',
                        currentMenu: currentMenu,
                        onMenuSelected: onMenuSelected,
                      ),
                      const SizedBox(width: 10),
                      TopNavButton(
                        icon: FontAwesomeIcons.utensils,
                        label: 'Thực đơn chính',
                        currentMenu: currentMenu,
                        onMenuSelected: onMenuSelected,
                      ),
                      const SizedBox(width: 10),
                      TopNavButton(
                        icon: FontAwesomeIcons.martiniGlass,
                        label: 'Đồ uống',
                        currentMenu: currentMenu,
                        onMenuSelected: onMenuSelected,
                      ),
                      const SizedBox(width: 10),
                      TopNavButton(
                        icon: FontAwesomeIcons.bowlRice,
                        label: 'Food court',
                        currentMenu: currentMenu,
                        onMenuSelected: onMenuSelected,
                      ),
                      const SizedBox(width: 10),
                      TopNavButton(
                        icon: FontAwesomeIcons.wheatAwn,
                        label: 'Đặc sản địa phương',
                        currentMenu: currentMenu,
                        onMenuSelected: onMenuSelected,
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            currentMenu == 'Tất cả'
                ? buildMainPage(context, branchId, selectedCategory, state)
                : buildMenuPage(menuItems[currentMenu]!, context),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_base_v2/features/home/domain/entities/menu.dart'; // Ensure to import the Menu entity
// import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
// import 'package:flutter_base_v2/features/home/presentation/widgets/header.dart';
// import 'package:flutter_base_v2/features/home/presentation/widgets/top_nav_button.dart';
// import 'package:get/get.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class HomePageContent extends StatelessWidget {
//   final String currentMenu;
//   final String branchId;
//   final Function(String) onMenuSelected;

//   HomePageContent({
//     super.key,
//     required this.branchId,
//     required this.currentMenu,
//     required this.onMenuSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.find();

//     // Fetch menus only if the list is empty (to avoid repeated calls)
//     if (controller.menus.isEmpty) {
//       controller.getMenus(branchId: branchId, category: currentMenu);
//     }

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16),
//         child: Column(
//           children: [
//             buildHeader(context),
//             const SizedBox(height: 16),
//             buildTopNavButtons(context),
//             const SizedBox(height: 24),
//             Obx(() {
//               List<Menu> menuItems = controller.menus.toList();
//               return menuItems.isNotEmpty
//                   ? buildMenuList(menuItems)
//                   : Center(child: Text('No menus available for this category.'));
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTopNavButtons(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           TopNavButton(
//             icon: FontAwesomeIcons.bellConcierge,
//             label: 'Tất cả',
//             currentMenu: currentMenu,
//             onMenuSelected: onMenuSelected,
//           ),
//           const SizedBox(width: 10),
//           TopNavButton(
//             icon: FontAwesomeIcons.utensils,
//             label: 'Thực đơn chính',
//             currentMenu: currentMenu,
//             onMenuSelected: onMenuSelected,
//           ),
//           const SizedBox(width: 10),
//           TopNavButton(
//             icon: FontAwesomeIcons.martiniGlass,
//             label: 'Đồ uống',
//             currentMenu: currentMenu,
//             onMenuSelected: onMenuSelected,
//           ),
//           const SizedBox(width: 10),
//           TopNavButton(
//             icon: FontAwesomeIcons.bowlRice,
//             label: 'Food court',
//             currentMenu: currentMenu,
//             onMenuSelected: onMenuSelected,
//           ),
//           const SizedBox(width: 10),
//           TopNavButton(
//             icon: FontAwesomeIcons.wheatAwn,
//             label: 'Đặc sản địa phương',
//             currentMenu: currentMenu,
//             onMenuSelected: onMenuSelected,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildMenuList(List<Menu> menuItems) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(), // Prevent scrolling of inner list
//       itemCount: menuItems.length,
//       itemBuilder: (context, index) {
//         final menuItem = menuItems[index];
//         return Column(
//           children: menuItem.items.map((item) {
//             return ListTile(
//               title: Text(item.name),
//               subtitle: Text(item.description),
//               trailing: Text('\$${item.price.toString()}'), // Assuming the Item entity has a price field
//               onTap: () {
//                 // Handle menu item tap if needed
//               },
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
