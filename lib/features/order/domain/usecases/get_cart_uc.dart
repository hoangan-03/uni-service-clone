import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/cart_repo.dart';

class GetCartUseCase extends UseCaseIO<GetCartParams, Cart?> {
  final CartRepo _cartRepo;

  GetCartUseCase(this._cartRepo);

  @override
  Future<Cart?> build(GetCartParams input) {
    return _cartRepo.getCart(input.order);
  }
}
class GetCartParams {
  final String order;

  GetCartParams({required this.order});
}