import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/order/data/models/add_to_cart_request.dart';
import 'package:flutter_base_v2/features/order/data/models/cart_response.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<Cart?> getCart(String order) async {
    final CartResponse response = await _apiService.getCart(order);
    final CartApiModel? model = response.data;
    return (model != null) ? mappingEntity(model) : null;
  }
  @override
  Future<void> addToCart(String idProduct, int quantity) async {
    final request = AddToCartRequest(
      idProduct: idProduct,
      quantity: quantity,
    );
    await _apiService.addToCart(request);
  }
}
