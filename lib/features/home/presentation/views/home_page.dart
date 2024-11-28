import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/branch/presentation/views/branches_page.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account.dart';
import 'package:flutter_base_v2/features/transactions/presentation/views/history.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/home_page_content.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends BaseGetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final GetStorage localStorage = GetStorage();
    final appColors = Theme.of(context).extension<AppColors>();
    final branchJson = localStorage.read('selectedBranch');
    String branchId = S.default_branch;
    print("branchId: $branchId");

    if (branchJson != null) {
      final Map<String, dynamic> branchData = jsonDecode(branchJson);
      branchId = branchData['id'] ?? S.default_branch;
    }
    Theme.of(context).extension<AppColors>();
    int selectedIndex = 0;

    return Scaffold(
      backgroundColor: appColors?.white,
      body: Obx(() {
        String currentMenu = controller.currentMenu.value.isNotEmpty
            ? controller.currentMenu.value
            : S.all;

        return IndexedStack(
          index: selectedIndex,
          children: <Widget>[
            HomePageContent(
              getCartShipping: (){
                controller.getCartShipping();
              },
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
            const HistoryPage(),
            const AccountPage(),
          ],
        );
      }),
    );
  }
}
