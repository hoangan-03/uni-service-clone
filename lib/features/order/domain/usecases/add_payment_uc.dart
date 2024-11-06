import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/order/data/models/add_payment.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/payment_repo.dart';

class AddPaymentUseCase extends UseCaseIO<AddPaymentRequest, void> {
  final PaymentRepo _cartRepo;

  AddPaymentUseCase(this._cartRepo);

  @override
  Future<void> build(AddPaymentRequest input) {
    return _cartRepo.addPayment(input.cartId);
  }
}