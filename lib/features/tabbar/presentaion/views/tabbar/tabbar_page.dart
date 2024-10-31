import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_route.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

enum TabType { home, service, qr, history, account }

extension TabItem on TabType {
  Widget get icon {
    switch (this) {
      case TabType.home:
        return Icon(
          CupertinoIcons.home,
          size: 20,
          color: colorScheme.primary,
        );
      case TabType.service:
        return Icon(
          CupertinoIcons.square_list,
          size: 20,
          color: colorScheme.primary,
        );
      case TabType.qr:
        return Icon(
          CupertinoIcons.qrcode,
          size: 20,
          color: colorScheme.primary,
        );
      case TabType.history:
        return Icon(
          CupertinoIcons.time,
          size: 20,
          color: colorScheme.primary,
        );
      case TabType.account:
        return Icon(
          CupertinoIcons.person,
          size: 20,
          color: colorScheme.primary,
        );
    }
  }

  Widget get inactiveIcon {
    switch (this) {
      case TabType.home:
        return Icon(
          CupertinoIcons.home,
          size: 20,
          color: Get.context?.theme.disabledColor,
        );
      case TabType.service:
        return Icon(
          CupertinoIcons.square_list,
          size: 20,
          color: Get.context?.theme.disabledColor,
        );
      case TabType.qr:
        return Icon(
          CupertinoIcons.qrcode,
          size: 20,
          color: colorScheme.onPrimary,
        );
      case TabType.history:
        return Icon(
          CupertinoIcons.time,
          size: 20,
          color: Get.context?.theme.disabledColor,
        );
      case TabType.account:
        return Icon(
          CupertinoIcons.person,
          size: 20,
          color: Get.context?.theme.disabledColor,
        );
    }
  }

  String get title {
    switch (this) {
      case TabType.home:
        return 'Trang chủ';
      case TabType.service:
        return 'Tiện ích';
      case TabType.qr:
        return 'QR';
      case TabType.history:
        return 'Lịch sử';
      case TabType.account:
        return 'Tài khoản';
    }
  }

  Widget get page {
    switch (this) {
      case TabType.home:
        return AppRoute.getPage(AppRoute.home)?.page() ?? Container();
      case TabType.service:
        return AppRoute.getPage(AppRoute.service)?.page() ?? Container();
      case TabType.qr:
        return AppRoute.getPage(AppRoute.qr)?.page() ?? Container();
      case TabType.history:
        return AppRoute.getPage(AppRoute.history)?.page() ?? Container();
      case TabType.account:
        return AppRoute.getPage(AppRoute.account)?.page() ?? Container();
    }
  }

  PersistentBottomNavBarItem get item {
    return PersistentBottomNavBarItem(
      icon: icon,
      inactiveIcon: inactiveIcon,
      title: title.isEmpty ? null : title,
      activeColorPrimary: colorScheme.primary,
      inactiveColorPrimary: Get.context?.theme.disabledColor,
    );
  }
}

class TabbarPage extends GetView {
  const TabbarPage({super.key});

  List<Widget> _buildScreens() {
    return TabType.values.map((e) => e.page).toList();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return TabType.values.map((e) => e.item).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PersistentTabView(
          context,
          backgroundColor:
              Get.context?.theme.appBarTheme.backgroundColor ?? Colors.white,
          controller: PersistentTabController(initialIndex: 0),
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineToSafeArea: true,
          padding: const EdgeInsets.only(top: 10),
          resizeToAvoidBottomInset: true,
          decoration: const NavBarDecoration(
            colorBehindNavBar: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(80, 187, 176, 222),
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          navBarStyle: NavBarStyle.style15,
          onItemSelected: (index) {},
        ),
      ],
    );
  }
}
