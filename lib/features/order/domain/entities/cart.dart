
import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';
import 'package:flutter_base_v2/features/order/data/models/cart_detail.dart';

@jsonSerializable
class Cart with PrettyJsonMixin{
  String? id = '';
  int? totalPrice = 0;
  List<CartDetail>? cartDetail = [];
}
