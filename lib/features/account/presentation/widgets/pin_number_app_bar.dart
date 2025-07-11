import 'package:flutter/material.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';

AppBar buildPinNumberAppBar(
    BuildContext context, AccountController controller, bool isCreated) {
  final appColors = Theme.of(context).extension<AppColors>();

  return AppBar(
    backgroundColor: appColors?.white,
    title: Obx(() => Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            controller.isReType.value
                ? S.of(context).confirm_pin
                : (isCreated
                    ? S.of(context).create_pin
                    : (controller.isCheckOldPin.value
                        ? S.of(context).enter_new_pin
                        : S.of(context).enter_old_pin)),
            textAlign: TextAlign.center,
            style: AppTextStyle.bold14().copyWith(color: appColors?.secondary),
          ),
        )),
    centerTitle: true,
    automaticallyImplyLeading: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
        controller.resetAll();
      },
    ),
  );
}
