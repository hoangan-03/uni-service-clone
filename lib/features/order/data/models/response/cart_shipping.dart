import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/features/branch/domain/entities/branch.dart';
import 'package:flutter_base_v2/features/order/data/models/response/order_detail.dart';

@jsonSerializable
class CartShippingApiModel {
  String? id;
  String? orderDate;
  int? totalPrice;
  List<OrderDetail>? orderDetails; 
  Branch? branch;
}
