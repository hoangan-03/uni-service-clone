// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
// import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
// import 'package:flutter_base_v2/features/branch/presentation/pages/branches_page.dart';
// import 'package:flutter_base_v2/features/account/presentation/views/account.dart';
// import 'package:flutter_base_v2/features/qrcode/presentation/views/qrcode.dart';
// import 'package:flutter_base_v2/features/history/presentation/views/history.dart';
// import 'package:flutter_base_v2/features/home/presentation/views/home_page_content.dart';
// import 'package:get/get.dart';
// import 'package:flutter_base_v2/utils/config/app_theme.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter_base_v2/utils/config/app_text_style.dart';

// class HomePage extends BaseGetView<HomeController> {
//   const HomePage({super.key});

//   @override
//   Widget myBuild(BuildContext context) {
//     final GetStorage localStorage = GetStorage();

//     final branchJson = localStorage.read('selectedBranch');
//     String branchId = 'Sample ID';

//     if (branchJson != null) {
//       final Map<String, dynamic> branchData = jsonDecode(branchJson);
//       branchId = branchData['id'] ?? 'Sample';
//     }
//     final appColors = Theme.of(context).extension<AppColors>();
//     int selectedIndex = 0;
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 32.0),
//               Expanded(
//                 child: controller.getMenusState.widget(
//                   onLoading: const Center(child: CircularProgressIndicator()),
//                   onSuccess: (menus) {
//                     return ListView.builder(
//                       itemCount: menus?.length,
//                       itemBuilder: (context, index) {
//                         final menu = menus![index];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ListTile(
//                               title: Text(menu.product?.name ?? 'sfdf'),
//                               // subtitle: item.id != null && item.id!.isNotEmpty
//                               //     ? Text(
//                               //         item.id!,
//                               //         style: AppTextStyle.regular12()
//                               //             .copyWith(color: appColors?.gray),
//                               //       )
//                               //     : null,
//                             )
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   onError: (error) => Center(child: Text('Error: $error')),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/branch/presentation/pages/branches_page.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account.dart';
import 'package:flutter_base_v2/features/qrcode/presentation/views/qrcode.dart';
import 'package:flutter_base_v2/features/history/presentation/views/history.dart';
import 'package:flutter_base_v2/features/home/presentation/views/home_page_content.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends BaseGetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final GetStorage localStorage = GetStorage();

    final branchJson = localStorage.read('selectedBranch');
    String branchId = '6134edff-d5cc-4dbc-be51-4c914bfded16';

    if (branchJson != null) {
      final Map<String, dynamic> branchData = jsonDecode(branchJson);
      branchId = branchData['id'] ?? 'Sample';
    }
    print(branchId);
    final appColors = Theme.of(context).extension<AppColors>();
    int selectedIndex = 0;

    return Scaffold(
      body: Obx(() {
        String currentMenu = controller.currentMenu.value.isNotEmpty
            ? controller.currentMenu.value
            : 'Tất cả';

        return IndexedStack(
          index: selectedIndex,
          children: <Widget>[
            HomePageContent(
              menuTodayState: controller.getMenuTodayState,
              menuPreoderState: controller.getMenuPreorderState,
              menuDrinkState: controller.getMenuDrinkState,
              menuFoodcourtState: controller.getMenuFoodcourtState,
              menuSpecialityState: controller.getMenuSpecialityState,
              menuNecessityState: controller.getMenuNecessityState,
              branchId: controller.currentBranchID.value,
              selectedCategory: controller.currentCategory.value,
              currentMenu: currentMenu,
              onMenuSelected: (menu) {
                controller.selectMenu(menu);
              },
            ),
            const BranchsPage(),
            const QRPage(),
            const HistoryPage(),
            const AccountPage(),
          ],
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services),
            label: 'Tiện ích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Mã QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: appColors?.primary,
        unselectedItemColor: appColors?.gray,
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 1) {
            Get.to(() => const BranchsPage());
          } else {
            selectedIndex = index;
          }
        },
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_binding.dart';
// import 'package:flutter_base_v2/features/branch/presentation/pages/branches_page.dart';
// import 'package:flutter_base_v2/features/account/presentation/views/account.dart';
// import 'package:flutter_base_v2/features/qrcode/presentation/views/qrcode.dart';
// import 'package:flutter_base_v2/features/history/presentation/views/history.dart';
// import 'package:flutter_base_v2/features/home/presentation/views/home_page_content.dart'; 
// import 'package:get/get.dart';
// import 'package:flutter_base_v2/utils/config/app_theme.dart';
// // import 'package:flutter_base_v2/utils/config/app_text_style.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//   String _currentMenu = 'Tất cả';

//   late List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();
//     _pages = <Widget>[
//       HomePageContent(
//         currentMenu: _currentMenu,
//         onMenuSelected: _onMenuSelected,
//       ),
//       const BranchsPage(),
//       const QRPage(),
//       const HistoryPage(),
//       const AccountPage(),
//     ];
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _onMenuSelected(String menu) {
//     setState(() {
//       _currentMenu = menu;
//       _pages[0] = HomePageContent(
//         currentMenu: _currentMenu,
//         onMenuSelected: _onMenuSelected,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appColors = Theme.of(context).extension<AppColors>();
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Trang chủ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.design_services),
//             label: 'Tiện ích',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.qr_code),
//             label: 'Mã QR',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'Lịch sử',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Tài khoản',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: appColors?.primary,
//         unselectedItemColor: appColors?.gray,
//         showUnselectedLabels: true,
//         onTap: (index) {
//           if (index == 1) {
//             Get.to(() => const BranchsPage(), binding: BranchBinding());
//           } else {
//             _onItemTapped(index);
//           }
//         },
//       ),
//     );
//   }
// }
