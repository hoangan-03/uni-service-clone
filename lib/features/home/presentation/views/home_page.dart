import 'package:flutter/material.dart';
import '../../data/types/menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> todayMenuItems = [
      MenuItem(
        name: 'Cơm gà',
        description: 'Cơm gà mềm, sốt đậm đà.',
        price: '40.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/plate-food-with-chicken-rice-vegetables-it_1220-7940.jpg',
      ),
      MenuItem(
        name: 'Cơm bò',
        description: 'Cơm thịt bò xào kèm rau sống.',
        price: '45.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/white-bowl-food-with-meat-vegetables-meat_1220-7948.jpg',
      ),
      MenuItem(
        name: 'Phở',
        description: 'Phở bò nước dùng ngon, bánh mềm.',
        price: '45.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/bowl-food-with-bowl-food-that-says-noodle_1220-7952.jpg',
      ),
    ];

    final List<MenuItem> tomorrowMenuItems = [
      MenuItem(
        name: 'Cơm gà',
        description: 'Cơm gà thơm ngon, sốt đặc biệt.',
        price: '30.000 - 40.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/plate-food-with-chicken-rice-vegetables-it_1220-7940.jpg',
      ),
      MenuItem(
        name: 'Cơm bò',
        description: 'Cơm bò sốt đậm đà, rau tươi.',
        price: '30.000 - 40.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/white-bowl-food-with-meat-vegetables-meat_1220-7948.jpg',
      ),
      MenuItem(
        name: 'Phở',
        description: 'Phở bò nước dùng thanh, bánh mềm.',
        price: '45.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/bowl-food-with-bowl-food-that-says-noodle_1220-7952.jpg',
      ),
    ];

    final List<MenuItem> drinksMenuItems = [
      MenuItem(
        name: 'Cà phê đá',
        description: 'Cà phê lạnh, đậm đà vị cà phê.',
        price: '20.000 đ',
        imageUrl:
            'https://img.freepik.com/free-vector/white-cup-hot-coffee-with-cinnamon-saucer-beans-wooden-table-realistic_1284-56783.jpg',
      ),
      MenuItem(
        name: 'Bạc sỉu nóng',
        description: 'Cà phê sữa nóng, ngọt ngào.',
        price: '20.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/cup-coffee-with-bowl-with-cookies-teaspoon_1232-904.jpg',
      ),
      MenuItem(
        name: 'Trà đào',
        description: 'Trà đào thơm mát, giải khát tuyệt vời.',
        price: '30.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/glass-peach-tea-with-ice-cubes_123827-21615.jpg',
      ),
    ];

    final List<MenuItem> foodCourtMenuItems = [
      MenuItem(
        name: 'Bánh ngọt',
        description: 'Bánh ngọt ngọt ngào, thơm ngon.',
        price: '35.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/delicious-cake-with-forest-fruits-composition_23-2149095722.jpg',
      ),
      MenuItem(
        name: 'Bánh xếp',
        description: 'Bánh xếp nhân hấp dẫn.',
        price: '25.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/flat-lay-asian-dumplings-dish-with-herbs-copy-space_23-2148694348.jpg',
      ),
      MenuItem(
        name: 'Hamburger',
        description: 'Hamburger với thịt và rau tươi.',
        price: '40.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/big-sandwich-hamburger-burger-with-beef-red-onion-tomato-fried-bacon_2829-5398.jpg',
      ),
    ];

    final List<MenuItem> localSpecialtiesMenuItems = [
      MenuItem(
        name: 'Mì Quảng',
        description: 'Mì Quảng với nước dùng đậm đà.',
        price: '35.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/tasty-assortment-noodles-table_23-2148803848.jpg',
      ),
      MenuItem(
        name: 'Bún bò Huế',
        description: 'Bún bò Huế cay nồng, hấp dẫn.',
        price: '40.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/noodles-with-pork-pork-balls-chilli-paste-with-soup-thai-style-vegetable-boat-noodles-selective-focus-top-view_1150-45664.jpg',
      ),
      MenuItem(
        name: 'Cơm Tấm',
        description: 'Cơm tấm với sườn nướng thơm ngon.',
        price: '45.000 đ',
        imageUrl:
            'https://img.freepik.com/free-photo/rice-with-chinese-pork-stewed-pork-beautiful-side-dishes-thai-food_1150-24212.jpg',
      ),
    ];

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
                    _buildTopNavButton(Icons.restaurant_menu, 'Tất cả'),
                    const SizedBox(width: 10),
                    _buildTopNavButton(Icons.restaurant, 'Thực đơn chính'),
                    const SizedBox(width: 10),
                    _buildTopNavButton(Icons.local_drink, 'Đồ uống'),
                    const SizedBox(width: 10),
                    _buildTopNavButton(Icons.food_bank, 'Food court'),
                    const SizedBox(width: 10),
                    _buildTopNavButton(Icons.local_offer, 'Đặc biệt'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Today's menu section
              _buildSectionHeader(
                  'Thực đơn hôm nay', 'Xem menu', context, todayMenuItems),
              const SizedBox(height: 10),
              _buildFoodList(todayMenuItems),

              // Tomorrow's menu section
              const SizedBox(height: 16),
              _buildSectionHeader(
                  'Chọn món ngày mai', 'Xem menu', context, tomorrowMenuItems),
              const SizedBox(height: 10),
              _buildFoodList(tomorrowMenuItems),

              // Drinks section
              const SizedBox(height: 16),
              _buildSectionHeader(
                  'Đồ uống', 'Xem menu', context, drinksMenuItems),
              const SizedBox(height: 10),
              _buildFoodList(drinksMenuItems),

              // Food Court section
              const SizedBox(height: 16),
              _buildSectionHeader(
                  'Food Court', 'Xem menu', context, foodCourtMenuItems),
              const SizedBox(height: 10),
              _buildFoodList(foodCourtMenuItems),

              // Local Specialties section
              const SizedBox(height: 16),
              _buildSectionHeader('Đặc sản địa phương', 'Xem menu', context,
                  localSpecialtiesMenuItems),
              const SizedBox(height: 10),
              _buildFoodList(localSpecialtiesMenuItems),
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
        currentIndex: 0, // default selected index
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildTopNavButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: Colors.black),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
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
}

void main() => runApp(const MaterialApp(
      home: HomePage(),
    ));
