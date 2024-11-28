import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/order/presentation/views/order.dart';
import 'package:flutter_base_v2/features/order/presentation/views/order_slider.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';

Widget buildMenuPage(
  BuildContext context,
  String currentMenu,
  BaseState<List<Menu>?> menuTodayState,
  BaseState<List<Menu>?> menuPreorderState,
  BaseState<List<Menu>?> menuFoodcourtState,
  BaseState<List<Menu>?> menuDrinkState,
  BaseState<List<Menu>?> menuSpecialityState,
  BaseState<List<Menu>?> menuNecessityState,
) {
  final appColors = Theme.of(context).extension<AppColors>();
  final HomeController controller = Get.find<HomeController>();
  BaseState<List<Menu>?> currentList;

  switch (currentMenu) {
    case 'Thực đơn hôm nay':
      currentList = menuTodayState;
      break;
    case "Đồ uống":
      currentList = menuDrinkState;
      break;
    case "Food Court":
      currentList = menuFoodcourtState;
      break;
    case "Đặc sản địa phương":
      currentList = menuSpecialityState;
      break;
    case "Nhu yếu phẩm":
      currentList = menuNecessityState;
      break;
    default:
      currentList = BaseState();
      break;
  }

  return currentList.widget(
    onLoading: const Center(child: CircularProgressIndicator()),
    onSuccess: (menus) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menus?.length ?? 0,
        itemBuilder: (context, index) {
          final item = menus?[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: appColors?.gray ?? Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item?.product.imageURL ?? '',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, size: 80);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item?.product.name ?? '',
                        style: AppTextStyle.bold15()
                            .copyWith(color: appColors?.secondary),
                      ),
                      Text(
                        item?.product.description ?? '',
                        style: AppTextStyle.medium14()
                            .copyWith(color: appColors?.secondary),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: appColors?.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.add, color: appColors?.white, size: 18),
                  ),
                  onPressed: () {
                    showOrderSlider(
                      context,
                      item!,
                      initialQuantity: controller.quantity.value,
                      onQuantityChanged: (newQuantity) {
                        controller.updateQuantity(newQuantity);
                      },
                      onOrderPlaced: () {
                        Get.to(() => OrderPage(
                          item: item,
                          quantity: 1,
                          itemIndex: 0,
                        ));
                      },
                      shouldNavigate: true,
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    },
    onError: (error) {
      debugPrint('Errorbug: $error');
      return Center(child: Text('Error: $error'));
    },
  );
}
