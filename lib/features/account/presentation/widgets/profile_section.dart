import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/option_item.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/qr_code_image.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/show_options.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_svg_url.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Widget buildProfileSection(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Stack(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                showOptions(
                  SS.change_image_from,
                  [
                    buildOptionItem(
                      appColors,
                      AppSvgUrl.icTakepicture,
                      SS.camera,
                      () async {
                        await controller.pickImage(ImageSource.camera);
                      },
                    ),
                    buildOptionItem(
                      appColors,
                      AppSvgUrl.icPhotogallery,
                      SS.gallery,
                      () async {
                        await controller.pickImage(ImageSource.gallery);
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
