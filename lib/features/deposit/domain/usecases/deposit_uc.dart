import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/deposit/data/models/request/deposit_request.dart';
import 'package:flutter_base_v2/features/deposit/domain/entities/deposit.dart';
import 'package:flutter_base_v2/features/deposit/domain/repositories/deposit_repo.dart';

class DepositRequestUseCase extends UseCaseIO<DepositRequest, Deposit> {
  final DepositRepo _depositRepo;

  DepositRequestUseCase(this._depositRepo);

  @override
  Future<Deposit> build(DepositRequest input) {
    return _depositRepo.depositRequest(input.price);
  }
}
