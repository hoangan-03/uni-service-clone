import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/get_cate_title.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/menu/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/item/item_card.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

Widget buildItemList(
    BuildContext context, String category, BaseState<List<Menu>?> state ) {
  final appColors = Theme.of(context).extension<AppColors>();
  return SizedBox(
    child: state.widget(
      onLoading: const Center(child: CircularProgressIndicator()),
      onSuccess: (menusMap) {
        return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getCategoryTitle(category),
                      style: AppTextStyle.bold18(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuPage(
                                title: category, menuItems: menusMap ?? []),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Xem menu",
                            style: AppTextStyle.bold16()
                                .copyWith(color: appColors?.primary),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: appColors?.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: menusMap!
                        .map((menu) => Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: buildItemCard(menu, context),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ));
      },
      onError: (error) {
        debugPrint('Errorbug: $error');
        return Center(child: Text('Error: $error'));
      },
    ),
  );
}