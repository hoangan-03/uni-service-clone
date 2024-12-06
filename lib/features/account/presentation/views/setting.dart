import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

class SettingPage extends BaseGetView<AccountController> {
  const SettingPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      backgroundColor: appColors!.white,
      appBar: buildAppBar(
        context: context,
        title: S.settings,
        appColors: appColors,
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingListItem(
              title: S.language,
              subtitle: S.show_selected_lang,
              onTap: () {
                // Ngôn ngữ
              },
            ),
            SettingListItem(
              title: S.password,
              subtitle: S.change_pass,
              onTap: () {
                // Đổi mật khẩu
              },
            ),
            SettingListItem(
              title: S.pin_number,
              subtitle: S.change_pin,
              onTap: () {
                N.toUpdatePin();
              },
            ),
            Obx(() {
              return SettingSwitchItem(
                title: S.face_id,
                subtitle: S.use_face_id,
                value: controller.isFaceIdEnabled.value,
                onChanged: (bool value) {
                  controller.isFaceIdEnabled.value = value;
                  // Face ID
                },
              );
            }),
            Obx(() {
              return SettingSwitchItem(
                title: S.dark_mode,
                subtitle: S.change_dark_mode,
                value: controller.isDarkModeEnabled.value,
                onChanged: (bool value) {
                  controller.isDarkModeEnabled.value = value;
                  controller.switchTheme();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class SettingListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.medium14()
                      .copyWith(color: appColors?.secondary),
                ),
                Text(
                  subtitle,
                  style:
                      AppTextStyle.regular12().copyWith(color: appColors?.gray),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 12),
          ],
        ),
      ),
    );
  }
}

class SettingSwitchItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingSwitchItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.medium14()
                    .copyWith(color: appColors?.secondary),
              ),
              Text(
                subtitle,
                style:
                    AppTextStyle.regular12().copyWith(color: appColors?.gray),
              ),
            ],
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 100), // Faster animation duration
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Platform.isIOS
                ? CupertinoSwitch(
                    key: ValueKey<bool>(value),
                    value: value,
                    onChanged: onChanged,
                    activeColor: appColors?.primary,
                    trackColor: appColors?.gray.withOpacity(0.5),
                  )
                : Switch(
                    key: ValueKey<bool>(value),
                    value: value,
                    onChanged: onChanged,
                    activeColor: appColors?.primary,
                    inactiveTrackColor: appColors?.gray.withOpacity(0.5),
                  ),
          ),
        ],
      ),
    );
  }
}