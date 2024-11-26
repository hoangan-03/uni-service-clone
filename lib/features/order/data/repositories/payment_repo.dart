import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/order/data/models/request/add_payment_request.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/payment_repo.dart';

class PaymentRepoImpl extends PaymentRepo {
  final ApiService _apiService = Get.find();
  @override
  Future<void> addPayment(String cartId) async {
    final request = AddPaymentRequest(
      cartId: cartId,
    );
    await _apiService.addPayment(request);
  }
}
