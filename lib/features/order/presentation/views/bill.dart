import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/bill_id.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/bill_time_stamp.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/expired_dart.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/order_detail_header.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/order_item_details.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/order_status_button.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/qr_code_image.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/return_home_button.dart';
import 'package:flutter_base_v2/features/order/presentation/widgets/total_price.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class BillPage extends BaseGetView<HomeController> {
  final String name;
  final String description;
  final int quantity;
  final int totalPrice;
  final String branch;
  final String imageUrl;
  final String branchName;

  const BillPage({
    super.key,
    required this.name,
    required this.description,
    required this.quantity,
    required this.totalPrice,
    required this.branch,
    required this.imageUrl,
    required this.branchName,
  });

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: buildAppBar(
          appColors: appColors,
          context: context,
          title: S.bill,
          hasBackButton: false),
      body: _buildBody(context, appColors),
    );
  }

  Widget _buildBody(BuildContext context, AppColors? appColors) {
    final String currentTime =
       AppConstants.dateTimeFormat.format(DateTime.now());
    return SingleChildScrollView(
      child: Container(
        color: appColors!.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on,
                      color: appColors.secondary, size: 16),
                  const SizedBox(width: 3.0),
                  Text(
                    branchName,
                    style: AppTextStyle.bold14()
                        .copyWith(color: appColors.secondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            buildExpirationDate(context),
            const SizedBox(height: 4.0),
            buildOrderStatusButton(context),
            const SizedBox(height: 4.0),
            buildQRCodeImage(controller, appColors),
            const SizedBox(height: 8.0),
            buildBillTimestamp(currentTime, context),
            const SizedBox(height: 8.0),
            buildBillId(controller, context),
            const SizedBox(height: 16.0),
            buildOrderDetailsHeader(context),
            const SizedBox(height: 4.0),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 6.0),
            buildOrderItemDetails(
                context, quantity, totalPrice, name, description, imageUrl),
            const SizedBox(height: 6.0),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 6.0),
            buildTotalPrice(context, totalPrice),
            const SizedBox(height: 12.0),
            buildReturnHomeButton(context, controller),
          ],
        ),
      ),
    );
  }
}
