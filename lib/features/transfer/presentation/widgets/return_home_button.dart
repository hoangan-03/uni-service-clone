import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';

ElevatedButton buildReturnHomeButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      N.toHome(input: HomeInput("transfer"));
    },
    style: elevatedButtonStyle(context),
    child: Text(
      S.of(context).back_to_home,
      style:  elevatedButtonTextStyle(context),
    ),
  );
}
