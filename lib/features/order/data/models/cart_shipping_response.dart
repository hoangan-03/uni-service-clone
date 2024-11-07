import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/features/branch/domain/entities/branch.dart';

@jsonSerializable
class CartShippingResponse extends BaseResponse {
  List<CartShippingApiModel>? data;
}

@jsonSerializable
class CartShippingApiModel {
  String? id;
  String? orderDate;
  int? totalPrice;
  List<OrderDetail>? orderDetails; 
  Branch? branch;
}

@jsonSerializable
class OrderDetail {
  String? id;
  String? productItem;
  String? productName;
  String? productDescription;
  String? productImage;
  String? menuId;
  int? price;
  int? quantity;
}