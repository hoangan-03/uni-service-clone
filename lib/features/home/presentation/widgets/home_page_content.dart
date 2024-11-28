import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/header.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/main_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/menu/menu_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/top_nav_button.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_svg_url.dart';

class HomePageContent extends StatelessWidget {
  final String currentMenu;
  final String branchId;
  final String selectedCategory;
  final Function(String) onMenuSelected;
  final BaseState<List<Menu>?> menuTodayState;
  final BaseState<List<Menu>?> menuPreoderState;
  final BaseState<List<Menu>?> menuFoodcourtState;
  final BaseState<List<Menu>?> menuDrinkState;
  final BaseState<List<Menu>?> menuSpecialityState;
  final BaseState<List<Menu>?> menuNecessityState;
  final Function() getCartShipping;

  const HomePageContent({
    super.key,
    required this.branchId,
    required this.currentMenu,
    required this.onMenuSelected,
    required this.menuTodayState,
    required this.menuPreoderState,
    required this.menuFoodcourtState,
    required this.menuDrinkState,
    required this.menuSpecialityState,
    required this.menuNecessityState,
    required this.selectedCategory,
    required this.getCartShipping,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context, getCartShipping),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TopNavButton(
                    svgUrl: AppSvgUrl.icAllfood,
                    label: S.all,
                    currentMenu: currentMenu,
                    onMenuSelected: onMenuSelected,
                  ),
                  const SizedBox(width: 10),
                  TopNavButton(
                    svgUrl:  AppSvgUrl.icMainDish,
                    label: S.current_menu,
                    currentMenu: currentMenu,
                    onMenuSelected: onMenuSelected,
                  ),
                  const SizedBox(width: 10),
                  TopNavButton(
                    svgUrl: AppSvgUrl.icDrink,
                    label: S.drink,
                    currentMenu: currentMenu,
                    onMenuSelected: onMenuSelected,
                  ),
                  const SizedBox(width: 10),
                  TopNavButton(
                    svgUrl: AppSvgUrl.icFoodcourt,
                    label: S.foodcourt,
                    currentMenu: currentMenu,
                    onMenuSelected: onMenuSelected,
                  ),
                  const SizedBox(width: 10),
                  TopNavButton(
                    svgUrl: AppSvgUrl.icLocalfood,
                    label: S.local_food,
                    currentMenu: currentMenu,
                    onMenuSelected: onMenuSelected,
                  ),
                ],
              ),
            ),
            currentMenu == S.all
                ? buildMainPage(
                    context,
                    branchId,
                    selectedCategory,
                    menuTodayState,
                    menuPreoderState,
                    menuFoodcourtState,
                    menuDrinkState,
                    menuSpecialityState,
                    menuNecessityState)
                : buildMenuPage(
                    context,
                    currentMenu,
                    menuTodayState,
                    menuPreoderState,
                    menuFoodcourtState,
                    menuDrinkState,
                    menuSpecialityState,
                    menuNecessityState),
          ],
        ),
      ),
    );
  }
}
