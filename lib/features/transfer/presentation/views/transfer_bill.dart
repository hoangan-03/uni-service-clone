import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/views/tabbar/tabbar_page.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransferBillPage extends BaseGetView<TransferController> {
  final String recipientName;
  final String phone;
  final String amount;

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
          title: 'Chi tiết chuyển tiền',
          hasBackButton: true),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBillTimestamp(currentTime),
            const SizedBox(height: 8.0),
            _buildReturnHomeButton(appColors),
          ],
        ));
  }

  Text _buildBillTimestamp(String currentTime) {
    return Text(
      currentTime,
      style: AppTextStyle.regular12().copyWith(color: Colors.grey),
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
          minimumSize: const Size(double.infinity, 40)),
      child: Text(
        'Quay về trang chủ',
        style: AppTextStyle.bold14().copyWith(color: appColors?.primary),
      ),
    );
  }
}
