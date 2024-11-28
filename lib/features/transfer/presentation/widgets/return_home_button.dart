import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

ElevatedButton buildReturnHomeButton(AppColors? appColors) {
  return ElevatedButton(
    onPressed: () {
      N.toHome(input: HomeInput("transfer"));
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      side: BorderSide(color: appColors?.primary ?? Colors.blue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      minimumSize: const Size(double.infinity, 40),
    ),
    child: Text(
      S.back_to_home,
      style: AppTextStyle.bold14().copyWith(color: appColors?.primary),
    ),
  );
}
