import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_base_v2/features/transactions/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_controller.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/icon_for_transaction_type.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/title_for_transaction_type.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionListView extends StatelessWidget {
  final TransactionController controller;

  const TransactionListView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return PagedListView<int, Transaction>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<Transaction>(
        itemBuilder: (context, transact, index) {
          final isFirstOfDay = index == 0 ||
              transact.createdAt!.day !=
                  controller
                      .pagingController.itemList![index - 1].createdAt!.day;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isFirstOfDay)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Center(
                      child: Text(
                        AppConstants.dateFormat.format(transact.createdAt!),
                        style: AppTextStyle.regular14()
                            .copyWith(color: appColors!.gray),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: appColors!.background,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: getIconForTransactionType(
                                      transact.type ?? '', appColors),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getTitleForTransactionType(
                                          transact.type ?? ''),
                                      style: AppTextStyle.bold14(),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      AppConstants.timeFormat
                                          .format(transact.createdAt!),
                                      style: AppTextStyle.regular14()
                                          .copyWith(color: appColors.gray),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${transact.type == "TRANSFER" ? "" : transact.type == 'DEPOSIT' ? '+' : '-'}${formatPrice(transact.point ?? 0).toString()} đ',
                        style: AppTextStyle.bold14()
                            .copyWith(color: appColors.secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        newPageProgressIndicatorBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        noItemsFoundIndicatorBuilder: (context) =>
            Center(child: Text('No transactions found')),
      ),
    );
  }
}
