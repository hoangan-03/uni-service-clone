import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/order/data/models/response/cart.dart';
import 'package:flutter_base_v2/features/order/data/models/response/cart_response.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart.dart';

abstract class CartRepo extends BaseMappingRepo<Cart, CartApiModel> {
  Future<Cart?> getCart(String category);
  Future<void> addToCart(String idProduct, int quantity);
}