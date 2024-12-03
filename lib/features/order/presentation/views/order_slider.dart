import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/helper/cancel_button.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_base_v2/features/order/presentation/views/order.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

void showOrderSlider(
  BuildContext context,
  Menu item, {
  required int initialQuantity,
  required Function(int) onQuantityChanged,
  Function(int)? onItemSelected,
  required Function() onOrderPlaced,
  required bool shouldNavigate,
  int? selectedItemIndex,
  int? orderQuantity,
}) {
  void navigateToOrderPage(int newIndex) {
    Get.to(() => OrderPage(
          item: item,
          quantity: initialQuantity,
          itemIndex: newIndex,
        ));
  }

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
        child: OrderSliderContent(
          item: item,
          initialQuantity: orderQuantity ?? initialQuantity,
          initialIndex: selectedItemIndex ?? 0,
          onQuantityChanged: onQuantityChanged,
          onItemSelected: (newIndex) {
            if (onItemSelected != null) {
              onItemSelected(newIndex);
            }
            navigateToOrderPage(newIndex);
          },
          onOrderPlaced: (int selectedItemIndex) {
            if (shouldNavigate) {
              navigateToOrderPage(selectedItemIndex);
            }
          },
          shouldNavigate: shouldNavigate,
        ),
      );
    },
  );
}

class OrderSliderContent extends StatefulWidget {
  final Menu item;
  final int initialQuantity;
  final int initialIndex;
  final Function(int) onQuantityChanged;
  final Function(int)? onItemSelected;
  final Function(int selectedItemIndex) onOrderPlaced;
  final bool shouldNavigate;

  const OrderSliderContent({
    required this.item,
    required this.initialQuantity,
    required this.onQuantityChanged,
    required this.onOrderPlaced,
    required this.shouldNavigate,
    required this.onItemSelected,
    required this.initialIndex,
    super.key,
  });

  @override
  OrderSliderContentState createState() => OrderSliderContentState();
}

class OrderSliderContentState extends State<OrderSliderContent> {
  late int orderQuantity;
  late int? selectedItemIndex;

  @override
  void initState() {
    super.initState();
    orderQuantity = widget.initialQuantity > 0 ? widget.initialQuantity : 1;
    selectedItemIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    Get.find<HomeController>();
    final selectedItem = widget.item.items?[selectedItemIndex ?? 0];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: appColors!.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SliderHeader(),
            const SizedBox(height: 4),
            _OrderItemDetails(
              item: widget.item,
              selectedItem: selectedItem,
              orderQuantity: orderQuantity,
              onQuantityChanged: (newQuantity) {
                setState(() {
                  orderQuantity = newQuantity;
                });
              },
            ),
            const SizedBox(height: 16),
            if (widget.item.menu == "TODAY") ...[
              _TodayMenuOptions(
                item: widget.item,
                selectedItemIndex: selectedItemIndex,
                onItemSelected: (int? value) {
                  setState(() {
                    selectedItemIndex = value;
                  });
                },
              ),
            ],
            _OrderButton(
              onQuantityChanged: widget.onQuantityChanged,
              onItemSelected: widget.onItemSelected,
              onOrderPlaced: widget.onOrderPlaced,
              shouldNavigate: widget.shouldNavigate,
              orderQuantity: orderQuantity,
              selectedItemIndex: selectedItemIndex,
            ),
            const SizedBox(height: 2),
            CancelButton(),
          ],
        ),
      ),
    );
  }
}

class _SliderHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _OrderItemDetails extends StatelessWidget {
  final Menu item;
  final dynamic selectedItem;
  final int orderQuantity;
  final Function(int) onQuantityChanged;

  const _OrderItemDetails({
    required this.item,
    required this.selectedItem,
    required this.orderQuantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.product.imageURL,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedItem?.name ?? item.product.name,
                style:
                    AppTextStyle.bold15().copyWith(color: appColors?.primary),
              ),
              const SizedBox(height: 4),
              Text(
                item.product.description,
                style:
                    AppTextStyle.regular13().copyWith(color: appColors?.gray),
              ),
              const SizedBox(height: 18),
              Text(
                '${formatPrice(selectedItem?.price ?? (item.type.price != null && item.type.price != 0 ? item.type.price : item.items![0].price)!)}đ',
                style:
                    AppTextStyle.medium14().copyWith(color: appColors?.onSuccess),
              ),
              const SizedBox(height: 8),
              _QuantitySelector(
                orderQuantity: orderQuantity,
                onQuantityChanged: onQuantityChanged,
                originalQuantity: item.orignialQuantity,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class _QuantitySelector extends StatelessWidget {
  final int orderQuantity;
  final Function(int) onQuantityChanged;
  final int originalQuantity;

  const _QuantitySelector({
    required this.orderQuantity,
    required this.onQuantityChanged,
    required this.originalQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Row(
      children: [
        IconButton(
          icon: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: orderQuantity == 0 ? appColors?.gray : appColors?.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.remove, color: appColors?.white, size: 18),
          ),
          onPressed: () {
            if (orderQuantity > 0) {
              onQuantityChanged(orderQuantity - 1);
            }
          },
        ),
        Text(
          '$orderQuantity',
          style: AppTextStyle.regular14().copyWith(color: appColors?.secondary),
        ),
        IconButton(
          icon: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: orderQuantity == originalQuantity ? appColors?.gray : appColors?.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.add, color: appColors?.white, size: 18),
          ),
          onPressed: () {
            if (orderQuantity < originalQuantity) {
              onQuantityChanged(orderQuantity + 1);
            }
          },
        ),
        const SizedBox(width: 16),
        Text(
          'Còn lại: $originalQuantity',
          style: AppTextStyle.regular12().copyWith(color: appColors?.gray),
        ),
      ],
    );
  }
}

class _TodayMenuOptions extends StatelessWidget {
  final Menu item;
  final int? selectedItemIndex;
  final Function(int?) onItemSelected;

  const _TodayMenuOptions({
    required this.item,
    required this.selectedItemIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: item.items?.length ?? 0,
      itemBuilder: (context, index) {
        final menuItem = item.items![index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuItem.name,
                      style: AppTextStyle.regular15()
                          .copyWith(color: appColors?.secondary),
                    ),
                    Text(
                      'Còn lại: ${menuItem.quantity}',
                      style: AppTextStyle.regular12()
                          .copyWith(color: appColors?.gray),
                    ),
                  ],
                ),
              ),
              Radio<int>(
                value: index,
                groupValue: selectedItemIndex ?? 0,
                onChanged: onItemSelected,
                activeColor: appColors?.primary,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrderButton extends StatelessWidget {
  final Function(int) onQuantityChanged;
  final Function(int)? onItemSelected;
  final Function(int selectedItemIndex) onOrderPlaced;
  final bool shouldNavigate;
  final int orderQuantity;
  final int? selectedItemIndex;

  const _OrderButton({
    required this.onQuantityChanged,
    required this.onItemSelected,
    required this.onOrderPlaced,
    required this.shouldNavigate,
    required this.orderQuantity,
    required this.selectedItemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final controller = Get.find<HomeController>();
    return ElevatedButton(
      onPressed: () {
        onQuantityChanged(orderQuantity);
        if (onItemSelected != null) {
          onItemSelected!(selectedItemIndex ?? 0);
          controller.updateItemIndex(selectedItemIndex ?? 0);
        }
        Navigator.pop(context);
        if (shouldNavigate) {
          onOrderPlaced(selectedItemIndex ?? 0);
          controller.updateItemIndex(selectedItemIndex ?? 0);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors?.primary,
        minimumSize: const Size(double.infinity, 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        S.order,
        style: AppTextStyle.bold14().copyWith(color: Colors.white),
      ),
    );
  }
}
