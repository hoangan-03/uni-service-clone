import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'cart_detail.dart';

@jsonSerializable
class CartResponse extends BaseResponse {
  CartApiModel? data;
}

@jsonSerializable
class CartApiModel {
  String? id = '';
  int? totalPrice = 0;
  List<CartDetail>? cartDetail = [];
}