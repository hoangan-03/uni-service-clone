import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/features/order/data/models/response/cart_detail.dart';

@jsonSerializable
class CartApiModel {
  String? id = '';
  int? totalPrice = 0;
  List<CartDetail>? cartDetail = [];
}