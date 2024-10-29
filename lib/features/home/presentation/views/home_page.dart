import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_binding.dart';
import 'package:flutter_base_v2/features/branch/presentation/pages/branches_page.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account.dart';
import 'package:flutter_base_v2/features/qrcode/presentation/views/qrcode.dart';
import 'package:flutter_base_v2/features/history/presentation/views/history.dart';
import 'package:flutter_base_v2/features/home/presentation/views/home_page_content.dart'; 
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _currentMenu = 'Tất cả';

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePageContent(
        currentMenu: _currentMenu,
        onMenuSelected: _onMenuSelected,
      ),
      const BranchsPage(),
      const QRPage(),
      const HistoryPage(),
      const AccountPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onMenuSelected(String menu) {
    setState(() {
      _currentMenu = menu;
      _pages[0] = HomePageContent(
        currentMenu: _currentMenu,
        onMenuSelected: _onMenuSelected,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      body: _pages[_selectedIndex],
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
        currentIndex: _selectedIndex,
        selectedItemColor: appColors?.primary,
        unselectedItemColor: appColors?.gray,
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 1) {
            Get.to(() => const BranchsPage(), binding: BranchBinding());
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}