import 'dart:async';

import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/history/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/history/domain/usecases/get_transactions_cate_uc.dart';
import 'package:flutter_base_v2/features/history/domain/usecases/get_transactions_uc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionController extends BaseController {
  GetTransactionsUseCase get _getTransactionsUsecase =>
      Get.find<GetTransactionsUseCase>();
  GetTransactionsByCateUseCase get _getTransactionsByCateUsecase =>
      Get.find<GetTransactionsByCateUseCase>();
  BaseState<List<Transaction>?> getTransactionsState = BaseState();

  final PagingController<int, Transaction> pagingController =
      PagingController(firstPageKey: 1);
  final int pageSize = 20;

  final fromDate = Rx<DateTime?>(DateTime(2024, 10, 15));
  final toDate = Rx<DateTime?>(DateTime.now());
  final selectedTransactionType = Rx<String?>(null);

  @override
  void onInit() async {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    filterTransactions();
  }

  @override
  void onClose() {
    _getTransactionsUsecase.dispose();
    super.onClose();
  }

  Future<List<Transaction>> getTransactionsByCate(
      int page,
      int limit,
      String order,
      String transactionType,
      String field,
      String fromDate,
      String toDate) {
    final completer = Completer<List<Transaction>>();

    _getTransactionsByCateUsecase.execute(
      observer: Observer(
        onSubscribe: () {
          getTransactionsState.onLoading();
        },
        onSuccess: (List<Transaction>? transactions) {
          getTransactionsState.onSuccess(data: transactions);
          completer.complete(transactions ?? []);
        },
        onError: (AppException e) {
          getTransactionsState.onError(e.message);
          handleError(e);
          completer.completeError(e);
        },
      ),
      input: GetTransactionsByCateParams(
          page, limit, order, transactionType, field, fromDate, toDate),
    );

    return completer.future;
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final fromDateString = DateFormat('dd/MM/yyyy').format(fromDate.value!);
      final toDateString = DateFormat('dd/MM/yyyy').format(toDate.value!);

      List<Transaction> transactions;
      if (selectedTransactionType.value == null) {
        transactions = await getTransactions(
          pageKey,
          pageSize,
          'DESC',
          'createdAt',
          fromDateString,
          toDateString,
        );
      } else {
        transactions = await getTransactionsByCate(
          pageKey,
          pageSize,
          'DESC',
          selectedTransactionType.value!,
          'createdAt',
          fromDateString,
          toDateString,
        );
      }

      final isLastPage = transactions.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(transactions);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(transactions, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<Transaction>> getTransactions(
    int page,
    int limit,
    String order,
    String field,
    String fromDate,
    String toDate,
  ) async {
    final completer = Completer<List<Transaction>>();

    _getTransactionsUsecase.execute(
      observer: Observer(
        onSubscribe: () {
          getTransactionsState.onLoading();
        },
        onSuccess: (List<Transaction>? transactions) {
          getTransactionsState.onSuccess(data: transactions);
          completer.complete(transactions ?? []);
        },
        onError: (AppException e) {
          getTransactionsState.onError(e.message);
          handleError(e);
          completer.completeError(e);
        },
      ),
      input: GetTransactionsParams(page, limit, order, field, fromDate, toDate),
    );

    return completer.future;
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
    pagingController.refresh();
  }
}
}
