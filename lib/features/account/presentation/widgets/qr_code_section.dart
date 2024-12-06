// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/option_item.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/qr_code_image.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/show_options.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_svg_url.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget buildQRSection(BuildContext context) {
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
        buildQRCodeImage(appColors),
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
                S.of(context).current_money,
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
                          : S.of(context).hidden_star,
                      style: AppTextStyle.bold14().copyWith(
                        color: appColors.secondary,
                      ),
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
                  icon: SvgPicture.asset(
                    AppSvgUrl.icTopup,
                    width: 20,
                    height: 20,
                    color: appColors.primary,
                  ),
                  label: Text(
                    S.of(context).deposit,
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
                      S.of(context).option,
                      [
                        buildOptionItem(
                          appColors,
                          AppSvgUrl.icScanqr,
                          S.of(context).scan_qr,
                          () {
                            controller.selectQrOption();
                          },
                        ),
                        buildOptionItem(
                          appColors,
                          AppSvgUrl.icEnterphone,
                          S.of(context).enter_phone_number,
                          () {
                            Get.back();
                          },
                        ),
                      ],
                    );
                  },
                  icon: SvgPicture.asset(
                    AppSvgUrl.icTransfer,
                    width: 20,
                    height: 20,
                    color: appColors.primary,
                  ),
                  label: Text(
                    S.of(context).transfer_money,
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
