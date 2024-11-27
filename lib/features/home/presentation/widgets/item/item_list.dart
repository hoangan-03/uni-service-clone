import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/utils/helper/get_cate_title.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/menu/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/item/item_card.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';

Widget buildItemList(
    BuildContext context, String category, BaseState<List<Menu>?> state) {
  final appColors = Theme.of(context).extension<AppColors>();
  return SizedBox(
    child: state.widget(
      onLoading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getCategoryTitle(category),
                style: AppTextStyle.bold15(),
              ),
              GestureDetector(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.view_menu,
                      style: AppTextStyle.regular14()
                          .copyWith(color: appColors?.primary),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: appColors?.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: appColors!.lightGray,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
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
                      style: AppTextStyle.medium16(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => MenuPage(
                            title: category, menuItems: menusMap ?? []));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                           S.view_menu,
                            style: AppTextStyle.regular14()
                                .copyWith(color: appColors.primary),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: appColors.primary,
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
                              padding: const EdgeInsets.only(right: 10),
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
        debugPrint('Error: $error');
        return Center(child: Text('Error: $error'));
      },
    ),
  );
}
