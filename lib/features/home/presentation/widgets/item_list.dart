import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/item_card.dart';

Widget buildItemList(List<MenuItem> items, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: buildItemCard(item, context),
                ))
            .toList(),
      ),
    );
  }