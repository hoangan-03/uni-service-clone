import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_binding.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account_info.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/cancel_button.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/format_price.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AccountPage extends BaseGetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      backgroundColor: appColors!.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              _buildProfileSection(context),
              const SizedBox(height: 10),
              _buildQRSection(context),
              const SizedBox(height: 30),
              Column(
                children: [
                  _buildMenuItem(FontAwesomeIcons.circleUser,
                      'Thông tin tài khoản', context, onTap: () {
                    Get.to(() => const AccountInfoPage(),
                        binding: AccountBinding());
                  }),
                  Divider(color: appColors.lightGray),
                  _buildMenuItem(FontAwesomeIcons.gear, 'Cài đặt', context),
                  Divider(color: appColors.lightGray),
                  _buildMenuItem(
                      FontAwesomeIcons.commentDots, 'Đóng góp ý kiến', context),
                  Divider(color: appColors.lightGray),
                  _buildMenuItem(FontAwesomeIcons.idBadge, 'Liên hệ', context),
                  Divider(color: appColors.lightGray),
                  _buildMenuItem(
                      FontAwesomeIcons.lock, 'Chính sách bảo mật', context),
                  Divider(color: appColors.lightGray),
                  _buildMenuItem(FontAwesomeIcons.shieldHalved,
                      'Điều khoản dịch vụ', context),
                  Divider(color: appColors.lightGray),
                  _buildMenuItem(
                      FontAwesomeIcons.rightFromBracket, 'Đăng xuất', context,
                      color: appColors.onCancel,
                      showTrailingIcon: false, onTap: () {
                    controller.logout();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRSection(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage('assets/images/backgroundQR.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            appColors!.lightGray.withOpacity(0.15),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildQRCodeImage(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            decoration: BoxDecoration(
              color: appColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Số dư hiện tại',
                  style: AppTextStyle.regular14()
                      .copyWith(color: appColors.secondary),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      final user = controller.user.value;
                      return Text(
                        controller.isBalanceVisible.value
                            ? '${formatPrice(user.point ?? 0)} đ'
                            : '********',
                        style: AppTextStyle.bold14(),
                      );
                    }),
                    const SizedBox(width: 3),
                    Obx(() => GestureDetector(
                          onTap: () {
                            controller.isBalanceVisible.toggle();
                          },
                          child: Icon(
                            controller.isBalanceVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: appColors.gray,
                            size: 20,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 270,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      controller.navigateToDeposit();
                    },
                    icon: Icon(Icons.account_balance_wallet,
                        color: appColors.primary),
                    label: Text(
                      'Nạp tiền',
                      style: TextStyle(color: appColors.primary),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: appColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 270,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showOptions(
                        'Phương thức chuyển tiền',
                        [
                          _buildOptionItem(
                            appColors,
                            Icons.qr_code,
                            'Quét mã QR',
                            () {
                              Get.back();
                              N.toQrScanner();
                            },
                          ),
                          _buildOptionItem(
                            appColors,
                            Icons.phone_enabled,
                            'Nhập số điện thoại',
                            () {
                              Get.back();
                            },
                          ),
                        ],
                      );
                    },
                    icon: Icon(Icons.send, color: appColors.primary),
                    label: Text(
                      'Chuyển tiền',
                      style: TextStyle(color: appColors.primary),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: appColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeImage() {
    return Obx(() {
      final qrCode = "usr:${controller.user.value.id}";
      return QrImageView(
        data: qrCode,
        version: QrVersions.auto,
        size: 200.0,
        gapless: false,
        errorStateBuilder: (context, error) {
          return Center(
            child: Text(
              'Có lỗi xảy ra...',
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    });
  }

  Widget _buildProfileSection(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Stack(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                showOptions(
                  'Thay đổi hình từ',
                  [
                    _buildOptionItem(
                      appColors,
                      Icons.camera_alt,
                      'Chụp hình',
                      () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          final formattedFile = File(image.path);
                          controller.updateAvatar(formattedFile);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    _buildOptionItem(
                      appColors,
                      Icons.photo_library,
                      'Thư viện ảnh',
                      () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          final formattedFile = File(image.path);
                          controller.updateAvatar(formattedFile);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
              child: Stack(
                children: [
                  Obx(() {
                    final user = controller.user.value;
                    return CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        user.avatar ??
                            'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360',
                      ),
                      onBackgroundImageError: (_, __) =>
                          const Icon(Icons.error, size: 40),
                    );
                  }),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: appColors!.gray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final user = controller.user.value;
              return Column(
                children: [
                  Text(
                    user.username ?? '',
                    style: AppTextStyle.bold16()
                        .copyWith(color: appColors.secondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${user.position ?? ''} - Khoa ${user.faculty ?? ''}',
                    style: AppTextStyle.regular14()
                        .copyWith(color: appColors.gray),
                  ),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    BuildContext context, {
    Color color = Colors.black,
    bool showTrailingIcon = true,
    VoidCallback? onTap,
  }) {
    final appColors = Theme.of(context).extension<AppColors>();
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title,
                  style: AppTextStyle.regular13().copyWith(color: color)),
            ),
            if (showTrailingIcon)
              Icon(Icons.arrow_forward_ios, size: 12, color: appColors?.gray),
          ],
        ),
      ),
    );
  }

  void showOptions(String title, List<Widget> options) {
    final appColors = Theme.of(Get.context!).extension<AppColors>();
    showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: appColors?.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 10.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: appColors?.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: AppTextStyle.bold16()
                          .copyWith(color: appColors?.secondary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...options,
                const SizedBox(height: 16),
                CancelButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItem(
      AppColors? appColors, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: appColors?.lightGray.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: appColors?.primary),
      ),
      title: Text(
        title,
        style: AppTextStyle.bold14(),
      ),
      onTap: onTap,
    );
  }
}
