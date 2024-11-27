import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:intl/intl.dart';

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
        DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.now());
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBillTimestamp(currentTime),
          const SizedBox(height: 20),
          _buildTransferDetails(appColors),
          const Spacer(),
          _buildReturnHomeButton(appColors),
        ],
      ),
    );
  }

  Widget _buildBillTimestamp(String currentTime) {
    return Center(
      child: Text(
        currentTime,
        style: AppTextStyle.regular12().copyWith(color: Colors.grey),
      ),
    );
  }

  Column _buildTransferDetails(AppColors? appColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(S.recipient, recipientName),
        _buildDetailRow(S.phone, phone),
        _buildDetailRow(S.amount, '${NumberFormat('#,##0').format(amount)} đ'),
        _buildStatusRow(appColors),
      ],
    );
  }

  Padding _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label: ',
            style: AppTextStyle.regular15(),
          ),
          Text(
            value,
            style: AppTextStyle.bold15().copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Padding _buildStatusRow(AppColors? appColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.status,
            style: AppTextStyle.regular15(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: appColors!.primary,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              S.success,
              style: AppTextStyle.medium12().copyWith(color: appColors.white),
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildReturnHomeButton(AppColors? appColors) {
    return ElevatedButton(
      onPressed: () {
        N.toHome(input: HomeInput("transfer"));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: appColors?.primary ?? Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: Text(
        S.back_to_home,
        style: AppTextStyle.bold14().copyWith(color: appColors?.primary),
      ),
    );
  }
}
