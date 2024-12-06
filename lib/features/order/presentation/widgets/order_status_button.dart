import 'package:flutter/material.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

ElevatedButton buildOrderStatusButton(BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors?.onSuccess,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        minimumSize: const Size(80, 30), 
      ),
      child: Text(
       S.of(context).not_delivered,
        style: AppTextStyle.bold12().copyWith(color: appColors!.constantWhite),
      ),
    );
  }