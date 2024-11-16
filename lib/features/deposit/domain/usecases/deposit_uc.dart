import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/deposit/data/models/deposit_request.dart';
import 'package:flutter_base_v2/features/deposit/domain/repositories/deposit_repo.dart';
import 'package:flutter_base_v2/features/order/data/models/add_to_cart_request.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/cart_repo.dart';

class DepositRequestUseCase extends UseCaseIO<DepositRequest, void> {
  final DepositRepo _depositRepo;

  DepositRequestUseCase(this._depositRepo);

  @override
  Future<void> build(DepositRequest input) {
    return _depositRepo.depositRequest(input.price);
  }
}
