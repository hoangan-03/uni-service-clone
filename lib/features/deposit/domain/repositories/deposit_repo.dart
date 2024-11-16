import 'package:flutter_base_v2/base/data/base_repo.dart';

abstract class DepositRepo extends BaseMappingRepo<dynamic, dynamic> {
  Future<void> depositRequest(int price);
}
