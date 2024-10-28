import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_binding.dart';
import 'package:flutter_base_v2/features/branch/presentation/pages/branchs_page.dart';
import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
import 'package:flutter_base_v2/features/home/data/repositories/menu_mockdata.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/greetings.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/truncate_text.dart';
import 'package:flutter_base_v2/features/branch/presentation/pages/branch_select.dart';
import 'package:flutter_base_v2/features/home/presentation/views/menu/menu.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account.dart';
import 'package:flutter_base_v2/features/qrcode/presentation/views/qrcode.dart';
import 'package:flutter_base_v2/features/history/presentation/views/history.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
    });
  }



  @override
  Widget build(BuildContext context) {

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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
            _buildHeader(),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTopNavButton(FontAwesomeIcons.bellConcierge, 'Tất cả', context),
                  const SizedBox(width: 10),
                  _buildTopNavButton(FontAwesomeIcons.utensils, 'Thực đơn chính', context),
                  const SizedBox(width: 10),
                  _buildTopNavButton(FontAwesomeIcons.martiniGlass, 'Đồ uống', context),
                  const SizedBox(width: 10),
                  _buildTopNavButton(FontAwesomeIcons.bowlRice, 'Food court', context),
                  const SizedBox(width: 10),
                  _buildTopNavButton(FontAwesomeIcons.wheatAwn, 'Đặc sản địa phương', context),
                ],
              ),
            ),
            const SizedBox(height: 16),
            currentMenu == 'Tất cả'
                ? _buildAllMenuLayout(context)
                : _buildMenuPageLayout(menuItems[currentMenu]!),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(greeting, style: const TextStyle(fontSize: 18)),
                const Text('Nguyễn Hoàng Ân',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(truncateText("Sample", 30), style: const TextStyle(fontSize: 14, color: Colors.black)),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTopNavButton(IconData icon, String label, BuildContext context) {
    final bool isSelected = currentMenu == label;

    return GestureDetector(
      onTap: () {
        onMenuSelected(label);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(66, 63, 255, 0.08)
              : Colors.transparent,
          border: Border.all(color: const Color.fromARGB(255, 220, 220, 220)),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: isSelected ? const Color.fromRGBO(66, 63, 255, 1) : Colors.black),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? const Color.fromRGBO(66, 63, 255, 1) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllMenuLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Thực đơn hôm nay', 'Xem menu', context, todayMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(todayMenuItems, context),
        const SizedBox(height: 16),
        _buildSectionHeader('Chọn món ngày mai', 'Xem menu', context, tomorrowMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(tomorrowMenuItems, context),
        const SizedBox(height: 16),
        _buildSectionHeader('Đồ uống', 'Xem menu', context, drinksMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(drinksMenuItems, context),
        const SizedBox(height: 16),
        _buildSectionHeader('Food Court', 'Xem menu', context, foodCourtMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(foodCourtMenuItems, context),
        const SizedBox(height: 16),
        _buildSectionHeader('Đặc sản địa phương', 'Xem menu', context, localSpecialtiesMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(localSpecialtiesMenuItems, context),
      ],
    );
  }

  Widget _buildMenuPageLayout(List<MenuItem> items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.only(bottom: 12.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.price,
                      style: const TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(66, 63, 255, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
                onPressed: () {
                  // Handle add action
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, String actionText, BuildContext context, List<MenuItem> menuItems) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPage(title: title, menuItems: menuItems),
              ),
            );
          },
          child: Row(
            children: [
              Text(
                actionText,
                style: const TextStyle(color: Colors.blue),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoodList(List<MenuItem> items, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildFoodCard(item, context),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildFoodCard(MenuItem item, BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                item.price,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
