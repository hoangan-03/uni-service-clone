import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/transactions/data/models/response/transaction.dart';
import 'package:flutter_base_v2/features/transactions/domain/entities/transaction.dart';


abstract class TransactionRepo extends BaseMappingRepo<Transaction, TransactionApiModel> {

  Future<List<Transaction>?> getUserHistory(int page, int limit, String order, String field, String fromDate, String toDate);
  Future<List<Transaction>?> getUserHistoryByCategory(int page, int limit, String order, String transactionType, String field, String fromDate, String toDate);
}