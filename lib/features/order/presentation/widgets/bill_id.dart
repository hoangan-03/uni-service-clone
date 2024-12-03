  import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

Widget buildBillId(HomeController controller, BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
    return Obx(() {
      final billId = controller.qrmenu.value.id;
      return Text(
        '${S.bill_id}$billId',
        style: AppTextStyle.regular14().copyWith(color: appColors!.secondary),
      );
    });
  }