import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/item/item_list.dart';

Widget buildMainPage(BuildContext context, String branchId, String selectedCategory, BaseState<List<Menu>?> menuTodayState, BaseState<List<Menu>?> menuPreoderState, BaseState<List<Menu>?> menuFoodcourtState, BaseState<List<Menu>?> menuDrinkState, BaseState<List<Menu>?> menuSpecialityState, BaseState<List<Menu>?> menuNecessityState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        buildItemList(context,"TODAY", menuTodayState),
        // buildItemList(context,"PREORDER", menuPreoderState),
        buildItemList(context,"DRINK", menuDrinkState),
        buildItemList(context,"FOODCOURT", menuFoodcourtState),
        buildItemList(context,"SPECIALITY", menuSpecialityState),
        // buildItemList(context,"NECESSITY", menuNecessityState),
      ],
    );
  }