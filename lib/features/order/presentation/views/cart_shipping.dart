import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class CartShippingPage extends BaseGetView<HomeController> {
  const CartShippingPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng chưa nhận', textAlign: TextAlign.center),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              controller.getCartShippingState.widget(
                onLoading: const Center(child: CircularProgressIndicator()),
                onSuccess: (cartships) {
                  final branchName = cartships?.isNotEmpty == true
                      ? cartships![0].branch?.name ?? 'Unknown'
                      : 'Unknown';
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16.0,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            branchName,
                            style: AppTextStyle.regular14()
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartships?.length,
                          itemBuilder: (context, index) {
                            final cartship = cartships![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16.0),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      cartship.orderDetails?[0].productImage ??
                                          '',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartship.orderDetails![0].productName ??
                                            "",
                                        style: AppTextStyle.bold16(),
                                      ),
                                      if (cartship.orderDetails![0]
                                              .productDescription!.isNotEmpty ==
                                          true)
                                        Text(
                                          cartship.orderDetails?[0]
                                                  .productDescription ??
                                              '',
                                          style: AppTextStyle.regular12()
                                              .copyWith(color: appColors?.gray),
                                        ),
                                    ],
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'x${cartship.orderDetails?[0].quantity}',
                                        style: AppTextStyle.regular14(),
                                      ),
                                      Text(
                                        '${cartship.totalPrice} đ',
                                        style: AppTextStyle.bold16().copyWith(
                                            color: appColors?.primary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                onError: (error) => Center(child: Text('Error: $error')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
