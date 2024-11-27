import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_controller.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_base_v2/features/transactions/domain/entities/transaction.dart';

class HistoryPage extends BaseGetView<TransactionController> {
  const HistoryPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final DateFormat timeFormat = DateFormat('HH:mm');

    return Scaffold(
      backgroundColor: appColors?.white,
      appBar: buildAppBar(
        appColors: appColors,
        context: context,
        title: S.transaction_history,
        hasBackButton: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Column(
            children: [
              _buildTransactionTypeTabs(appColors!),
              const SizedBox(height: 16.0),
              _buildDateFilter(context),
              const SizedBox(height: 16.0),
              Expanded(
                child: PagedListView<int, Transaction>(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Transaction>(
                    itemBuilder: (context, transact, index) {
                      final isFirstOfDay = index == 0 ||
                          transact.createdAt!.day !=
                              controller.pagingController.itemList![index - 1]
                                  .createdAt!.day;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isFirstOfDay)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 4.0),
                                child: Center(
                                  child: Text(
                                    dateFormat.format(transact.createdAt!),
                                    style: AppTextStyle.regular14()
                                        .copyWith(color: appColors.gray),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: appColors.background,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: getIconForTransactionType(
                                                  transact.type ?? '',
                                                  appColors),
                                            ),
                                            const SizedBox(width: 16),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getTitleForTransactionType(
                                                      transact.type ?? ''),
                                                  style: AppTextStyle.bold14(),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  timeFormat.format(
                                                      transact.createdAt!),
                                                  style:
                                                      AppTextStyle.regular14()
                                                          .copyWith(
                                                              color: appColors
                                                                  .gray),
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
                        Center(child: Text(S.no_transactions_found)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeTabs(AppColors appColors) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabButton(S.all, null, appColors),
          const SizedBox(width: 10),
          _buildTabButton(S.buy, 'BUY', appColors),
          const SizedBox(width: 10),
          _buildTabButton(S.deposit_money, 'DEPOSIT', appColors),
          const SizedBox(width: 10),
          _buildTabButton(S.transfer_money, 'TRANSFER', appColors),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, String? type, AppColors appColors) {
    return Obx(() {
      final isSelected = controller.selectedTransactionType.value == type;
      return GestureDetector(
        onTap: () {
          controller.updateTransactionType(type);
          // controller.pagingController.refresh();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? appColors.background : appColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: AppTextStyle.bold12().copyWith(
              color: isSelected ? appColors.primary : appColors.secondary,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDateFilter(BuildContext context) {
    final TransactionController controller = Get.find<TransactionController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDatePicker(context, S.from, controller.fromDate, (date) {
          controller.updateFromDate(date);
          // controller.pagingController.refresh();
        }),
        const SizedBox(width: 16),
        _buildDatePicker(context, S.to, controller.toDate, (date) {
          controller.updateToDate(date);
          // controller.pagingController.refresh();
        }),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context, String label,
      Rx<DateTime?> date, Function(DateTime) onDateSelected,
      {DateTime? defaultDate}) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: AppTextStyle.bold14()),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: date.value ?? defaultDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (selectedDate != null) {
              onDateSelected(selectedDate);
            }
          },
          child: Container(
            width: 125,
            padding:
                const EdgeInsets.only(left: 8, right: 4, top: 4, bottom: 4),
            decoration: BoxDecoration(
              border: Border.all(color: appColors!.gray),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date.value != null
                        ? DateFormat('dd/MM/yyyy').format(date.value!)
                        : DateFormat('dd/MM/yyyy')
                            .format(defaultDate ?? DateTime.now()),
                    style: AppTextStyle.regular12(),
                  ),
                  Icon(Icons.expand_more, size: 20, color: appColors.gray),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Icon getIconForTransactionType(String transactionType, AppColors? appColors) {
    switch (transactionType) {
      case 'BUY':
        return Icon(FontAwesomeIcons.burger,
            color: appColors?.primary, size: 24);
      case 'SERVICES':
        return Icon(FontAwesomeIcons.squareParking,
            color: appColors?.onSuccess, size: 24);
      case 'DEPOSIT':
        return Icon(FontAwesomeIcons.wallet, color: Colors.orange, size: 24);
      case 'TRANSFER':
        return Icon(FontAwesomeIcons.moneyBillWave,
            color: Colors.blue, size: 24);
      case 'VENDING_MACHINE':
        return Icon(FontAwesomeIcons.store, color: Colors.purple, size: 24);
      default:
        return Icon(FontAwesomeIcons.question, color: Colors.grey, size: 24);
    }
  }

  String getTitleForTransactionType(String transactionType) {
    switch (transactionType) {
      case 'BUY':
        return S.buy;
      case 'DEPOSIT':
        return S.deposit_money;
      case 'TRANSFER':
        return S.transfer_money;
      default:
        return transactionType;
    }
  }
}