import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/history/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/history/domain/usecases/get_transactions_uc.dart';
import 'package:get/get.dart';

class TransactionController extends BaseController {
  GetTransactionsUseCase get _getTransactionsUsecase =>
      Get.find<GetTransactionsUseCase>();
  BaseState<List<Transaction>?> getTransactionsState = BaseState();

  @override
  void onInit() async {
    super.onInit();
    getTransactions(1, 20, 'DESC', 'createdAt', '12/11/2024', '15/11/2024');
  }

  @override
  void onClose() {
    _getTransactionsUsecase.dispose();
    super.onClose();
  }

  Future<void> getTransactions(int page, int limit, String order, String field,
      String fromDate, String toDate) {
    return _getTransactionsUsecase.execute(
      observer: Observer(
        onSubscribe: () {
          getTransactionsState.onLoading();
        },
        onSuccess: (List<Transaction>? transactions) {
          getTransactionsState.onSuccess(data: transactions);
        },
        onError: (AppException e) {
          getTransactionsState.onError(e.message);
          handleError(e);
        },
      ),
      input: GetTransactionsParams(page, limit, order, field, fromDate, toDate),
    );
  }
}
