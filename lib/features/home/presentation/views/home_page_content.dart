import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/header.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/main_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/menu/menu_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/top_nav_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  HomePageContent({
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


  });

  @override
  Widget build(BuildContext context) {
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
                ? buildMainPage(context, branchId, selectedCategory, menuTodayState, menuPreoderState, menuFoodcourtState, menuDrinkState, menuSpecialityState, menuNecessityState)
                : buildMenuPage(context,currentMenu,  menuTodayState, menuPreoderState, menuFoodcourtState, menuDrinkState, menuSpecialityState, menuNecessityState),
          ],
        ),
      ),
    );
  }
}
