// ignore_for_file: deprecated_member_use
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_route.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_svg_url.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

enum TabType { home, service, qr, history, account }

extension TabItem on TabType {
  Widget icon(Color color) {
    switch (this) {
      case TabType.home:
        return SvgPicture.asset(
          AppSvgUrl.icHome,
          color: color,
        );
      case TabType.service:
        return SvgPicture.asset(
          AppSvgUrl.icServices,
          color: color,
        );
      case TabType.qr:
        return SvgPicture.asset(
          AppSvgUrl.icQR,
          color: Colors.transparent,
        );
      case TabType.history:
        return SvgPicture.asset(
          AppSvgUrl.icHistory,
          color: color,
        );
      case TabType.account:
        return SvgPicture.asset(
          AppSvgUrl.icAccount,
          color: color,
        );
    }
  }

  String get title {
    switch (this) {
      case TabType.home:
        return S.home;
      case TabType.service:
        return S.services;
      case TabType.qr:
        return S.empty;
      case TabType.history:
        return S.history;
      case TabType.account:
        return S.account;
    }
  }

  Widget get page {
    switch (this) {
      case TabType.home:
        return AppRoute.getPage(AppRoute.home)?.page() ?? Container();
      case TabType.service:
        return AppRoute.getPage(AppRoute.service)?.page() ?? Container();
      case TabType.qr:
        return Container();
      case TabType.history:
        return AppRoute.getPage(AppRoute.history)?.page() ?? Container();
      case TabType.account:
        return AppRoute.getPage(AppRoute.account)?.page() ?? Container();
    }
  }

  PersistentBottomNavBarItem get item {
    return PersistentBottomNavBarItem(
      icon: icon(CupertinoColors.activeBlue),
      inactiveIcon: icon(CupertinoColors.systemGrey),
      title: title.isEmpty ? null : title,
      iconSize: 26,
      contentPadding: 10,
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      activeColorSecondary: CupertinoColors.activeBlue,
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
    final appColors = Theme.of(context).extension<AppColors>();
    final initialIndex = Get.arguments as dynamic ?? 0;
    return Stack(
      children: [
        PersistentTabView(
          context,
          backgroundColor: appColors!.white,
          controller: PersistentTabController(initialIndex: initialIndex),
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineToSafeArea: true,
          padding: const EdgeInsets.only(top: 10),
          resizeToAvoidBottomInset: true,
          decoration: NavBarDecoration(
            colorBehindNavBar: appColors.white,
            boxShadow: [
              BoxShadow(
                color: appColors.gray.withOpacity(0.8),
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          navBarStyle: NavBarStyle.style13,
          onItemSelected: (index) {},
        ),
        Positioned(
          bottom: 20,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: FloatingActionButton(
              onPressed: () {
                Get.toNamed(AppRoute.qr);
              },
              backgroundColor: appColors.primary,
              child: SvgPicture.asset(
                AppSvgUrl.icQR,
                width: 30,
                height: 30,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
