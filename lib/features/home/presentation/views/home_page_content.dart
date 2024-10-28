import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
import 'package:flutter_base_v2/features/home/data/repositories/menu_mockdata.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/greetings.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/header.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/main_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/menu_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/top_nav_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageContent extends StatelessWidget {
  final String currentMenu;
  final String greeting = getGreeting();
  final Function(String) onMenuSelected;

  HomePageContent({
    super.key,
    required this.currentMenu,
    required this.onMenuSelected,
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
            buildHeader(),
            const SizedBox(height: 16),
            SingleChildScrollView(
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
            ),
            const SizedBox(height: 16),
            currentMenu == 'Tất cả'
                ? buildMainPage(context)
                : buildMenuPage(menuItems[currentMenu]!),
          ],
        ),
      ),
    );
  }
}