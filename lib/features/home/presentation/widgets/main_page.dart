import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/data/repositories/menu_mockdata.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/item_list.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/section_header.dart';

Widget buildMainPage(BuildContext context, String branchId, String selectedCategory, BaseState<List<Menu>?> menuTodayState, BaseState<List<Menu>?> menuPreoderState, BaseState<List<Menu>?> menuFoodcourtState, BaseState<List<Menu>?> menuDrinkState, BaseState<List<Menu>?> menuSpecialityState, BaseState<List<Menu>?> menuNecessityState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader('Thực đơn hôm nay', 'Xem menu', context, todayMenuItems),
        const SizedBox(height: 10),
        buildItemList(context,"TODAY", menuTodayState),
        const SizedBox(height: 16),
        buildSectionHeader('Chọn món ngày mai', 'Xem menu', context, tomorrowMenuItems),
        const SizedBox(height: 10),
        buildItemList(context,"PREORDER", menuPreoderState),
        const SizedBox(height: 16),
        buildSectionHeader('Đồ uống', 'Xem menu', context, drinksMenuItems),
        const SizedBox(height: 10),
        buildItemList(context,"DRINK", menuDrinkState),
        const SizedBox(height: 16),
        buildSectionHeader('Food Court', 'Xem menu', context, foodCourtMenuItems),
        const SizedBox(height: 10),
        buildItemList(context,"FOODCOURT", menuFoodcourtState),
        const SizedBox(height: 16),
        buildSectionHeader('Đặc sản địa phương', 'Xem menu', context, localSpecialtiesMenuItems),
        const SizedBox(height: 10),
        buildItemList(context,"SPECIALITY", menuSpecialityState),
      ],
    );
  }