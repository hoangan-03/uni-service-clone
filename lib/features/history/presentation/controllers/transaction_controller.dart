import 'dart:async';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/history/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/history/domain/usecases/get_transactions_cate_uc.dart';
import 'package:flutter_base_v2/features/history/domain/usecases/get_transactions_uc.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionController extends BaseController {
  final Logger logger = Logger();

  GetTransactionsUseCase get _getTransactionsUsecase =>
      Get.find<GetTransactionsUseCase>();
  GetTransactionsByCateUseCase get _getTransactionsByCateUsecase =>
      Get.find<GetTransactionsByCateUseCase>();
  BaseState<List<Transaction>?> getTransactionsState = BaseState();

  final PagingController<int, Transaction> pagingController =
      PagingController(firstPageKey: 1);
  final int pageSize = 8;

  var isLoading = false.obs;

  final fromDate = Rx<DateTime?>(DateTime(2024, 10, 15));
  final toDate = Rx<DateTime?>(DateTime.now());
  final selectedTransactionType = Rx<String?>(null);

  @override
  void onInit() async {
    super.onInit();
    L.info('Adding page request listener');
    pagingController.addPageRequestListener((pageKey) {
      logger.i('Page request listener triggered for page $pageKey');
      _fetchPage(pageKey);
    });
  }

  @override
  void onClose() {
    _getTransactionsUsecase.dispose();
    pagingController.dispose();
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
          isLoading.value =
              true; // Set loading to true when data is being fetched
        },
        onSuccess: (List<Transaction>? transactions) {
          getTransactionsState.onSuccess(data: transactions);
          isLoading.value = false; // Set loading to false once data is loaded
          completer.complete(transactions ?? []);
        },
        onError: (AppException e) {
          getTransactionsState.onError(e.message);
          isLoading.value = false; // Set loading to false in case of an error
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
    if (isLoading.value) {
      return;
    }

    try {
      final fromDateString = DateFormat('dd/MM/yyyy').format(fromDate.value!);
      final toDateString = DateFormat('dd/MM/yyyy').format(toDate.value!);

      List<Transaction> newTransactions;
      if (selectedTransactionType.value == null) {
        newTransactions = await getTransactions(
          pageKey,
          pageSize,
          'DESC',
          'createdAt',
          fromDateString,
          toDateString,
        );
      } else {
        newTransactions = await getTransactionsByCate(
          pageKey,
          pageSize,
          'DESC',
          selectedTransactionType.value!,
          'createdAt',
          fromDateString,
          toDateString,
        );
      }
      final isLastPage = newTransactions.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newTransactions);
      } else {
        final nextPageKey = pageKey + newTransactions.length;
        pagingController.appendPage(newTransactions, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
      isLoading.value = false;
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
          isLoading.value =
              true; // Set loading to true when data is being fetched
        },
        onSuccess: (List<Transaction>? transactions) {
          getTransactionsState.onSuccess(data: transactions);
          isLoading.value = false; // Set loading to false once data is loaded
          completer.complete(transactions ?? []);
        },
        onError: (AppException e) {
          getTransactionsState.onError(e.message);
          isLoading.value = false; // Set loading to false in case of an error
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
    pagingController.refresh();
  }

  void updateToDate(DateTime date) {
    toDate.value = date;
    pagingController.refresh();
  }

  void updateTransactionType(String? type) {
    selectedTransactionType.value = type;
    pagingController.refresh();
  }
}
