import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/history/presentation/controllers/transaction_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class HistoryPage extends BaseGetView<TransactionController> {
  const HistoryPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      backgroundColor: appColors?.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 36.0),
              Expanded(
                child: controller.getTransactionsState.widget(
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onSuccess: (transaction) {
                    return ListView.builder(
                      itemCount: transaction?.length,
                      itemBuilder: (context, index) {
                        final transact = transaction![index];
                        return Obx(() => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(transact.type ?? '',
                                            style: AppTextStyle.regular16()),
                                        if (transact.userName?.isNotEmpty ==
                                            true)
                                          Text(
                                            transact.userName ?? '',
                                            style: AppTextStyle.regular12()
                                                .copyWith(
                                                    color: appColors?.gray),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  },
                  onError: (error) => Center(child: Text('Error: $error')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
