
  import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/helper/cancel_button.dart';
import 'package:get/get.dart';

void showOptions(String title, List<Widget> options) {
    final appColors = Theme.of(Get.context!).extension<AppColors>();
    showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: appColors?.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 10.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: appColors?.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: AppTextStyle.bold16()
                          .copyWith(color: appColors?.secondary),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...options,
                const SizedBox(height: 16),
                CancelButton(),
              ],
            ),
          ),
        );
      },
    );
  }