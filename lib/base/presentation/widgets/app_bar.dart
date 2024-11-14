import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

AppBar buildAppBar({
  required AppColors? appColors,
  required BuildContext context,
  required String? title,
  bool hasBackButton = true,
}) {
  return AppBar(
    backgroundColor: appColors?.white,
    title: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: AppTextStyle.bold16().copyWith(color: appColors?.secondary),
      ),
    ),
    centerTitle: true,
    automaticallyImplyLeading: hasBackButton,
    leading: hasBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        : null,
  );
}
