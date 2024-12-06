import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/tab_button.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

Widget buildTransactionTypeTabs(AppColors appColors) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTabButton(SS.all, null, appColors),
          const SizedBox(width: 10),
          buildTabButton(SS.buy, 'BUY', appColors),
          const SizedBox(width: 10),
          buildTabButton(SS.deposit_money, 'DEPOSIT', appColors),
          const SizedBox(width: 10),
          buildTabButton(SS.transfer_or_get_money, 'TRANSFER', appColors),
        ],
      ),
    );
  }