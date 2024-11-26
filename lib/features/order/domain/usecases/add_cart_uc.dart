import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/order/data/models/request/add_to_cart_request.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/cart_repo.dart';

class AddCartUseCase extends UseCaseIO<AddToCartRequest, void> {
  final CartRepo _cartRepo;

  AddCartUseCase(this._cartRepo);

  @override
  Future<void> build(AddToCartRequest input) {
    return _cartRepo.addToCart(input.idProduct, input.quantity);
  }
}