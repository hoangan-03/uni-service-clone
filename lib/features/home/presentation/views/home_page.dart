import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/views/menu/menu.dart';
import 'package:flutter_base_v2/features/home/data/repositories/menu_mockdata.dart';
import "package:flutter_base_v2/features/home/data/types/menu_item.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentMenu = 'Tất cả';

  @override
  Widget build(BuildContext context) {
    final Map<String, List<MenuItem>> menuItems = {
      'Tất cả': [...todayMenuItems, ...tomorrowMenuItems],
      'Thực đơn chính': todayMenuItems,
      'Đồ uống': drinksMenuItems,
      'Food court': foodCourtMenuItems,
      'Đặc sản địa phương': localSpecialtiesMenuItems,
    };

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Chào buổi sáng', style: TextStyle(fontSize: 18)),
                      Text('Nguyễn Văn A',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.black),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTopNavButton(
                        Icons.restaurant_menu, 'Tất cả', context),
                    const SizedBox(width: 10),
                    _buildTopNavButton(
                        Icons.restaurant, 'Thực đơn chính', context),
                    const SizedBox(width: 10),
                    _buildTopNavButton(Icons.local_drink, 'Đồ uống', context),
                    const SizedBox(width: 10),
                    _buildTopNavButton(Icons.food_bank, 'Food court', context),
                    const SizedBox(width: 10),
                    _buildTopNavButton(
                        Icons.local_offer, 'Đặc sản địa phương', context),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _currentMenu == 'Tất cả'
                  ? _buildAllMenuLayout()
                  : _buildMenuPageLayout(menuItems[_currentMenu]!),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_service),
            label: 'Dịch vụ',
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
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildTopNavButton(IconData icon, String label, BuildContext context) {
    final bool isSelected = _currentMenu == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentMenu = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(66, 63, 255, 0.08)
              : Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Icon(icon,
                size: 24,
                color: isSelected
                    ? const Color.fromRGBO(66, 63, 255, 1)
                    : Colors.black),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected
                    ? const Color.fromRGBO(66, 63, 255, 1)
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllMenuLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
            'Thực đơn hôm nay', 'Xem menu', context, todayMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(todayMenuItems),
        const SizedBox(height: 16),
        _buildSectionHeader(
            'Chọn món ngày mai', 'Xem menu', context, tomorrowMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(tomorrowMenuItems),
        const SizedBox(height: 16),
        _buildSectionHeader('Đồ uống', 'Xem menu', context, drinksMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(drinksMenuItems),
        const SizedBox(height: 16),
        _buildSectionHeader(
            'Food Court', 'Xem menu', context, foodCourtMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(foodCourtMenuItems),
        const SizedBox(height: 16),
        _buildSectionHeader('Đặc sản địa phương', 'Xem menu', context,
            localSpecialtiesMenuItems),
        const SizedBox(height: 10),
        _buildFoodList(localSpecialtiesMenuItems),
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
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
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
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 24),
                ),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, String actionText,
      BuildContext context, List<MenuItem> menuItems) {
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
                builder: (context) =>
                    MenuPage(title: title, menuItems: menuItems),
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

  Widget _buildFoodList(List<MenuItem> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildFoodCard(item),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildFoodCard(MenuItem item) {
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.price,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(66, 63, 255, 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Chọn món',
              style: TextStyle(
                  color: const Color.fromRGBO(66, 63, 255, 1), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: HomePage()));
