import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';

ElevatedButton buildReturnHomeButton(
    BuildContext context, HomeController controller) {
  Theme.of(context).extension<AppColors>();
  return ElevatedButton(
    onPressed: () {
      controller.updateQuantity(0);
      controller.updateItemIndex(0);
      N.toHome(input: HomeInput("bill"));
    },
    style: elevatedButtonStyle(context),
    child: Text(
      S.back_to_home,
      style:  elevatedButtonTextStyle(context),
    ),
  );
}
