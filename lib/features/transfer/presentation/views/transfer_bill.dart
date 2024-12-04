import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:flutter_base_v2/features/transfer/presentation/widgets/bill_timestamp.dart';
import 'package:flutter_base_v2/features/transfer/presentation/widgets/return_home_button.dart';
import 'package:flutter_base_v2/features/transfer/presentation/widgets/transfer_detail.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

class TransferBillPage extends BaseGetView<TransferController> {
  final String recipientName;
  final String phone;
  final int amount;

  const TransferBillPage({
    super.key,
    required this.recipientName,
    required this.phone,
    required this.amount,
  });

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: buildAppBar(
        appColors: appColors,
        context: context,
        title: S.transfer_detail,
        hasBackButton: false,
      ),
      body: _buildBody(context, appColors),
    );
  }

  Container _buildBody(BuildContext context, AppColors? appColors) {
    final String currentTime =
        AppConstants.dateTimeFormat.format(DateTime.now());
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBillTimestamp(currentTime),
          const SizedBox(height: 20),
          TransferDetails(
            recipientName: recipientName,
            phone: phone,
            amount: amount,
            appColors: appColors,
          ),
          const Spacer(),
          buildReturnHomeButton(context),
        ],
      ),
    );
  }
}
