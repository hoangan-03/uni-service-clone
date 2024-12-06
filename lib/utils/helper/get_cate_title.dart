import 'package:flutter/material.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:get/get.dart';

String getCategoryTitle(String category) {
  BuildContext context = Get.context!;
  switch (category) {
    case 'TODAY':
      return S.of(context).current_menu;
    case 'DRINK':
      return S.of(context).drink;
    case 'FOODCOURT':
      return S.of(context).foodcourt;
    case 'SPECIALITY':
      return S.of(context).local_food;
    case 'NECESSITY':
      return S.of(context).neccessities;
    default:
      return category;
  }
}