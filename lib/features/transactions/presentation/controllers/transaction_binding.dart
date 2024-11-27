import 'package:flutter_base_v2/features/transactions/domain/usecases/get_transactions_cate_uc.dart';
import 'package:flutter_base_v2/features/transactions/domain/usecases/get_transactions_uc.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_controller.dart';
import 'package:get/get.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionController());
    Get.lazyPut(() => GetTransactionsUseCase(Get.find()));
    Get.lazyPut(() => GetTransactionsByCateUseCase(Get.find()));
  }
}
