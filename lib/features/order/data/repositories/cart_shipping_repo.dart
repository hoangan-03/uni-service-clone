import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/order/data/models/cart_shipping_response.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart_shipping.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/cart_shipping.dart';

class CartShippingRepoImpl extends CartShippingRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<List<CartShipping>?> getCartShipping() async {
    final CartShippingResponse response = await _apiService.getCartShipping();
    final List<CartShippingApiModel>? apiModels = response.data;
       return apiModels?.map((model) => mappingEntity(model)).toList();
  }

}
