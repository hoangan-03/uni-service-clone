import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/history/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/history/domain/repositories/transaction_repo.dart';

class GetTransactionsByCateUseCase
    extends UseCaseIO<GetTransactionsByCateParams, List<Transaction>?> {
  final TransactionRepo _transactionRepo;

  GetTransactionsByCateUseCase(this._transactionRepo);

  @override
  Future<List<Transaction>?> build(GetTransactionsByCateParams input) {
    return _transactionRepo.getUserHistoryByCategory(
        input.page,
        input.limit,
        input.order,
        input.transactionType,
        input.field,
        input.fromDate,
        input.toDate);
  }
}

class GetTransactionsByCateParams {
  final int page;
  final int limit;
  final String order;
  final String transactionType;
  final String field;
  final String fromDate;
  final String toDate;

  GetTransactionsByCateParams(this.page, this.limit, this.order,
      this.transactionType, this.field, this.fromDate, this.toDate);
}
