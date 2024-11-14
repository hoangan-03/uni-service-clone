import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/history/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/history/domain/usecases/get_transactions_cate_uc.dart';
import 'package:flutter_base_v2/features/history/domain/usecases/get_transactions_uc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionController extends BaseController {
  GetTransactionsUseCase get _getTransactionsUsecase => Get.find<GetTransactionsUseCase>();
  GetTransactionsByCateUseCase get _getTransactionsByCateUsecase => Get.find<GetTransactionsByCateUseCase>();
  BaseState<List<Transaction>?> getTransactionsState = BaseState();

  final fromDate = Rx<DateTime?>(DateTime(2024, 10, 15));
  final toDate = Rx<DateTime?>(DateTime.now());
  final selectedTransactionType = Rx<String?>(null); 

  @override
  void onInit() async {
    super.onInit();
    filterTransactions(); 
  }

  @override
  void onClose() {
    _getTransactionsUsecase.dispose();
    super.onClose();
  }

  Future<void> getTransactionsByCate(int page, int limit, String order, String transactionType, String field, String fromDate, String toDate) {
    return _getTransactionsByCateUsecase.execute(
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
      input: GetTransactionsByCateParams(page, limit, order, transactionType, field, fromDate, toDate),
    );
  }

  Future<void> getTransactions(int page, int limit, String order, String field, String fromDate, String toDate) {
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

  void updateFromDate(DateTime date) {
    fromDate.value = date;
    filterTransactions(); 
  }

  void updateToDate(DateTime date) {
    toDate.value = date;
    filterTransactions(); 
  }

  void updateTransactionType(String? type) {
    selectedTransactionType.value = type;
  }

  void filterTransactions() {
    if (fromDate.value != null && toDate.value != null) {
      final fromDateString = DateFormat('dd/MM/yyyy').format(fromDate.value!);
      final toDateString = DateFormat('dd/MM/yyyy').format(toDate.value!);

      if (selectedTransactionType.value == null) {
        getTransactions(1, 50, 'DESC', 'createdAt', fromDateString, toDateString);
      } else {
        getTransactionsByCate(1, 20, 'DESC', selectedTransactionType.value!, 'createdAt', fromDateString, toDateString);
      }
    }
  }
}
