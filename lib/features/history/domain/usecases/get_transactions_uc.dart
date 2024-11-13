import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/history/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/history/domain/repositories/transaction_repo.dart';

class GetTransactionsUseCase
    extends UseCaseIO<TransactionInput, List<Transaction>?> {
  final TransactionRepo _transactionRepo;

  GetTransactionsUseCase(this._transactionRepo);

  @override
  Future<List<Transaction>?> build(TransactionInput input) {
    return _transactionRepo.getUserHistory(input.page, input.limit, input.order,
        input.field, input.fromDate, input.toDate);
  }
}

class TransactionInput {
  final int page;
  final int limit;
  final String order;
  final String field;
  final String fromDate;
  final String toDate;

  TransactionInput(this.page, this.limit, this.order, this.field, this.fromDate,
      this.toDate);
}
