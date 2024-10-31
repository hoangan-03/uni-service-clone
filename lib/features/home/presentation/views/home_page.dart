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
    Theme.of(context).extension<AppColors>();
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
    );
  }
}
