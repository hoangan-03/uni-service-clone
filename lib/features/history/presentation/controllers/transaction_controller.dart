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

      // Log some data of the transactions for debugging
      logger.i('Fetched ${newTransactions.length} transactions for page $pageKey');
      for (var transaction in newTransactions) {
        logger.i('Transaction ID: ${transaction.id}, Date: ${transaction.createdAt}');
      }

      if (newTransactions.isNotEmpty) {
        final isLastPage = newTransactions.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newTransactions);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newTransactions, nextPageKey);
        }
      } else {
        if (pageKey == 1) {
          pagingController.appendLastPage([]); // Empty list for the first page
        } else {
          pagingController.appendLastPage([]); // No more transactions
        }
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
    filterTransactions();
  }

  void filterTransactions() {
    if (fromDate.value != null && toDate.value != null) {
      pagingController.refresh();
    }
  }
}