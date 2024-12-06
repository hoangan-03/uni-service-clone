import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_controller.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/date_filter.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/transaction_list_view.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/transaction_type_tab.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

class HistoryPage extends BaseGetView<TransactionController> {
  const HistoryPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      backgroundColor: appColors?.white,
      appBar: buildAppBar(
        appColors: appColors,
        context: context,
        title: S.of(context).transaction_history,
        hasBackButton: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Column(
            children: [
              buildTransactionTypeTabs(context),
              const SizedBox(height: 16.0),
              const DateFilter(),
              const SizedBox(height: 16.0),
              Expanded(
                child: TransactionListView(
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
