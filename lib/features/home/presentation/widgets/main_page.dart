import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/data/repositories/menu_mockdata.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/item_list.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/section_header.dart';

Widget buildMainPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader('Thực đơn hôm nay', 'Xem menu', context, todayMenuItems),
        const SizedBox(height: 10),
        buildItemList(todayMenuItems, context),
        const SizedBox(height: 16),
        buildSectionHeader('Chọn món ngày mai', 'Xem menu', context, tomorrowMenuItems),
        const SizedBox(height: 10),
        buildItemList(tomorrowMenuItems, context),
        const SizedBox(height: 16),
        buildSectionHeader('Đồ uống', 'Xem menu', context, drinksMenuItems),
        const SizedBox(height: 10),
        buildItemList(drinksMenuItems, context),
        const SizedBox(height: 16),
        buildSectionHeader('Food Court', 'Xem menu', context, foodCourtMenuItems),
        const SizedBox(height: 10),
        buildItemList(foodCourtMenuItems, context),
        const SizedBox(height: 16),
        buildSectionHeader('Đặc sản địa phương', 'Xem menu', context, localSpecialtiesMenuItems),
        const SizedBox(height: 10),
        buildItemList(localSpecialtiesMenuItems, context),
      ],
    );
  }