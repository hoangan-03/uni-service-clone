import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/format_price.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/order/order.dart';
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
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
        child: OrderSliderContent(
          item: item,
          initialQuantity: initialQuantity,
          initialIndex: selectedItemIndex ?? 0,
          onQuantityChanged: onQuantityChanged,
          onItemSelected: onItemSelected,
          onOrderPlaced: (int selectedItemIndex) {
            if (shouldNavigate) {
              Get.to(() => OrderPage(
                    item: item,
                    quantity: initialQuantity,
                    itemIndex: selectedItemIndex,
                  ));
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
    orderQuantity = widget.initialQuantity;
    selectedItemIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final selectedItem = widget.item.items?[selectedItemIndex ?? 0];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Text(
              "Tuỳ chọn",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 36),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.item.product.imageURL,
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
                        selectedItem?.name ?? widget.item.product.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.item.product.description,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${formatPrice(selectedItem?.price ?? (widget.item.type.price != null && widget.item.type.price != 0 ? widget.item.type.price : widget.item.items![0].price)!)}đ',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(66, 63, 255, 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.remove,
                                  color: Colors.white, size: 18),
                            ),
                            onPressed: () {
                              setState(() {
                                if (orderQuantity > 0) {
                                  orderQuantity--;
                                }
                              });
                            },
                          ),
                          Text(
                            '$orderQuantity',
                            style: AppTextStyle.regular16()
                                .copyWith(color: appColors?.secondary),
                          ),
                          IconButton(
                            icon: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(66, 63, 255, 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.add,
                                  color: Colors.white, size: 18),
                            ),
                            onPressed: () {
                              setState(() {
                                if (orderQuantity <
                                    widget.item.orignialQuantity) {
                                  orderQuantity++;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 16),
                          if (widget.item.menu != "TODAY")
                            Text(
                              'Còn lại: ${widget.item.orignialQuantity}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (widget.item.menu == "TODAY") ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.item.items?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = widget.item.items![index];
                  return ListTile(
                    title: Text(
                      item.name,
                      style: AppTextStyle.regular16()
                          .copyWith(color: appColors?.secondary),
                    ),
                    subtitle: Text('Còn lại: ${item.quantity}',
                        style: AppTextStyle.regular12()
                            .copyWith(color: appColors?.gray)),
                    trailing: Radio<int>(
                      value: index,
                      groupValue: selectedItemIndex ?? 0,
                      onChanged: (int? value) {
                        setState(() {
                          selectedItemIndex = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ],
            ElevatedButton(
              onPressed: () {
                widget.onQuantityChanged(orderQuantity);
                if (widget.onItemSelected != null) {
                  widget.onItemSelected!(selectedItemIndex ?? 0);
                }
                Navigator.pop(context);
                if (widget.shouldNavigate) {
                  widget.onOrderPlaced(selectedItemIndex ?? 0);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Đặt món',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
