import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/features/order/data/models/response/cart_shipping.dart';

@jsonSerializable
class CartShippingResponse extends BaseResponse {
  List<CartShippingApiModel>? data;
}



