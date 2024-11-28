import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:intl/intl.dart';

class TransferDetails extends StatelessWidget {
  final String recipientName;
  final String phone;
  final int amount;
  final AppColors? appColors;

  const TransferDetails({
    super.key,
    required this.recipientName,
    required this.phone,
    required this.amount,
    required this.appColors,
  });

  @override
  Widget build(BuildContext context) {
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
}