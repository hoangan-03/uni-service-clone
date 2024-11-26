import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/order/data/models/response/cart_shipping.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart_shipping.dart';

abstract class CartShippingRepo extends BaseMappingRepo<CartShipping, CartShippingApiModel> {
  Future<List<CartShipping>?> getCartShipping();
}