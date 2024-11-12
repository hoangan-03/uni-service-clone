import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';
import 'package:flutter_base_v2/features/branch/domain/entities/branch.dart';

import 'package:flutter_base_v2/features/order/data/models/cart_shipping_response.dart';

@jsonSerializable
class CartShipping with PrettyJsonMixin {
  String? id = '';
  String? orderDate = '';
  int? totalPrice = 0;
  List<OrderDetail>? orderDetails = []; 
  Branch? branch;
}