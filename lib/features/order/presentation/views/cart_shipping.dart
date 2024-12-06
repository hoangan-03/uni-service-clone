import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart_shipping.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class CartShippingPage extends BaseGetView<HomeController> {
  const CartShippingPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: buildAppBar(
          appColors: appColors, context: context, title: SS.not_received_order),
      body: _buildBody(appColors),
    );
  }

  Widget _buildBody(AppColors? appColors) {
    return Container(
      color: appColors?.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Expanded(
              child: _buildCartShippingList(appColors),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartShippingList(AppColors? appColors) {
    return controller.getCartShippingState.widget(
      onLoading: const Center(child: CircularProgressIndicator()),
      onSuccess: (cartships) {
        if (cartships == null || cartships.isEmpty) {
          return Center(child: Text(SS.empty_cart));
        }
        return _CartShippingList(cartships: cartships, appColors: appColors);
      },
      onError: (error) => Center(child: Text('Error: $error')),
    );
  }
}

class _CartShippingList extends StatelessWidget {
  final List<CartShipping>? cartships;
  final AppColors? appColors;

  const _CartShippingList({this.cartships, this.appColors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cartships != null && cartships!.isNotEmpty)
          _buildBranchLocation(appColors),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            itemCount: cartships?.length,
            itemBuilder: (context, index) {
              final cartship = cartships![index];
              return _CartShippingItem(
                cartship: cartship,
                appColors: appColors,
              );
            },
          ),
        ),
      ],
    );
  }

  Row _buildBranchLocation(AppColors? appColors) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16.0,
          color: appColors?.gray,
        ),
        const SizedBox(width: 4.0),
        Text(
          cartships?.first.branch?.name ?? '',
          style: AppTextStyle.regular14().copyWith(color: appColors!.gray),
        ),
      ],
    );
  }
}

class _CartShippingItem extends StatelessWidget {
  final CartShipping cartship;
  final AppColors? appColors;

  const _CartShippingItem({required this.cartship, this.appColors});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: appColors?.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              cartship.orderDetails?[0].productImage ?? '',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          title: _buildProductTitle(),
          trailing: _buildProductPrice(),
        ),
      ),
    );
  }

  Column _buildProductTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartship.orderDetails![0].productName ?? "",
          style: AppTextStyle.bold16().copyWith(color: appColors?.secondary),
        ),
        if (cartship.orderDetails![0].productDescription!.isNotEmpty == true)
          Text(
            cartship.orderDetails?[0].productDescription ?? '',
            style: AppTextStyle.regular12().copyWith(color: appColors?.gray),
          ),
      ],
    );
  }

  Column _buildProductPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'x${cartship.orderDetails?[0].quantity}',
          style: AppTextStyle.regular14(),
        ),
        Text(
          '${formatPrice(cartship.totalPrice ?? 0)} đ',
          style: AppTextStyle.bold16().copyWith(color: appColors?.primary),
        ),
      ],
    );
  }
}
