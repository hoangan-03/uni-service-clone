import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360',
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Nguyễn Văn A',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Sinh viên - Khoa quản trị',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                    FontAwesomeIcons.user, 'Thông tin tài khoản', context),
                const SizedBox(height: 10),
                _buildMenuItem(FontAwesomeIcons.cog, 'Cài đặt', context),
                const SizedBox(height: 10),
                _buildMenuItem(
                    FontAwesomeIcons.comment, 'Đóng góp ý kiến', context),
                const SizedBox(height: 10),
                _buildMenuItem(FontAwesomeIcons.envelope, 'Liên hệ', context),
                const SizedBox(height: 10),
                _buildMenuItem(
                    FontAwesomeIcons.lock, 'Chính sách bảo mật', context),
                const SizedBox(height: 10),
                _buildMenuItem(
                    FontAwesomeIcons.shieldHalved, 'Điều khoản dịch vụ', context),
                const Divider(),
                const SizedBox(height: 10),
                _buildMenuItem(
                    FontAwesomeIcons.rightFromBracket, 'Đăng xuất', context,
                    color: Colors.red, showTrailingIcon: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context,
      {Color color = Colors.black, bool showTrailingIcon = true}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: showTrailingIcon
          ? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
          : null,
      onTap: () {},
    );
  }
}
