import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/deposit/data/models/deposit_response.dart';
import 'package:flutter_base_v2/features/deposit/domain/entities/deposit.dart';

abstract class DepositRepo extends BaseMappingRepo<Deposit, DepositApiModel> {
  Future<Deposit> depositRequest(int price);
}
