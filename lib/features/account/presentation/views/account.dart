import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_binding.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account_info.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';

class AccountPage extends BaseGetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          Column(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360',
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() {
                final user = controller.user.value;
                return Column(
                  children: [
                    Text(
                      user.username ?? '',
                      style: AppTextStyle.bold20().copyWith(color: appColors?.secondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${user.position ?? ''} - Khoa ${user.faculty ?? ''}',
                      style: AppTextStyle.regular16().copyWith(color: Colors.grey),
                    ),
                  ],
                );
              }),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                    FontAwesomeIcons.circleUser, 'Thông tin tài khoản', context,
                    onTap: () {
                  Get.to(() => const AccountInfoPage(), binding: AccountBinding());
                }),
                const SizedBox(height: 10),
                _buildMenuItem(FontAwesomeIcons.gear, 'Cài đặt', context),
                const SizedBox(height: 10),
                _buildMenuItem(
                    FontAwesomeIcons.commentDots, 'Đóng góp ý kiến', context),
                const SizedBox(height: 10),
                _buildMenuItem(FontAwesomeIcons.idBadge, 'Liên hệ', context),
                const SizedBox(height: 10),
                _buildMenuItem(
                    FontAwesomeIcons.lock, 'Chính sách bảo mật', context),
                const SizedBox(height: 10),
                _buildMenuItem(FontAwesomeIcons.shieldHalved,
                    'Điều khoản dịch vụ', context),
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
      {Color color = Colors.black,
      bool showTrailingIcon = true,
      VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title:
          Text(title, style: AppTextStyle.regular16().copyWith(color: color)),
      trailing: showTrailingIcon
          ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
          : null,
      onTap: onTap,
    );
  }
}