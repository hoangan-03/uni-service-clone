import 'package:flutter_base_v2/base/data/base_repo.dart';

abstract class PaymentRepo extends BaseMappingRepo<dynamic, dynamic> {
  Future<void> addPayment(String cartId);
}