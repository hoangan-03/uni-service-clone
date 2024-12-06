// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/helper/truncate_text.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_svg_url.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_route.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';

Widget buildHeader(
    BuildContext context, Function getCartShipping, String branchName) {
  final appColors = Theme.of(context).extension<AppColors>();
  final AccountController accountController = Get.find<AccountController>();

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Obx(() {
            final user = accountController.user.value;
            return ClipOval(
              child: Image.network(
                user.avatar ?? AppImageConstants.defaultAvatar,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 50);
                },
              ),
            );
          }),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final user = accountController.user.value;
                return Text(
                  user.username ?? S.of(context).empty,
                  style: AppTextStyle.bold16()
                      .copyWith(color: appColors?.secondary),
                );
              }),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.branch);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    color: appColors!.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: appColors.gray, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppSvgUrl.icLocation,
                        width: 16,
                        height: 16,
                        color: appColors.secondary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        truncateText(branchName, 25),
                        style: AppTextStyle.regular12()
                            .copyWith(color: appColors.secondary),
                      ),
                      const SizedBox(width: 3),
                      Icon(Icons.expand_more,
                          color: appColors.secondary, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      IconButton(
        icon: SvgPicture.asset(
          AppSvgUrl.icOrder,
          width: 20,
          height: 20,
          color: appColors.secondary,
        ),
        onPressed: () {
          getCartShipping();
          Get.toNamed(AppRoute.cartShipping);
        },
      ),
    ],
  );
}
