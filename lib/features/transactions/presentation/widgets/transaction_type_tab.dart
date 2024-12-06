import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/tab_button.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

Widget buildTransactionTypeTabs(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTabButton(S.of(context).all, null, appColors!),
          const SizedBox(width: 10),
          buildTabButton(S.of(context).buy, 'BUY', appColors),
          const SizedBox(width: 10),
          buildTabButton(S.of(context).deposit_money, 'DEPOSIT', appColors),
          const SizedBox(width: 10),
          buildTabButton(S.of(context).transfer_or_get_money, 'TRANSFER', appColors),
        ],
      ),
    );
  }