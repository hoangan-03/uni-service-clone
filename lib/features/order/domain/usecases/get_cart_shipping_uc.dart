import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart_shipping.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/cart_shipping.dart';

class GetCartShippingUseCase extends UseCaseIO<void, List<CartShipping>?> {
  final CartShippingRepo _cartRepo;

  GetCartShippingUseCase(this._cartRepo);

  @override
  Future<List<CartShipping>?> build(void input) {
    return _cartRepo.getCartShipping();
  }
}