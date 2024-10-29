import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';

@jsonSerializable
class MenuResponse extends BaseResponse {
  List<MenuApiModel>? data; 
}

@jsonSerializable
class MenuApiModel {
  String? id;
  String? branchId; 
  int? quantity; 
  int? orignialQuantity; 
  int? orderedQuantity;
  String? status;
  String? menu; 
  DateTime? dateSale; 
  DateTime? createdAt;
  bool? isRemoved;
  int? sortOrder; 
  DateTime? updatedAt; 
  ProductApiModel? product; 
  List<ItemApiModel>? items;

}

@jsonSerializable
class ProductApiModel {
  String? id;
  String? name;
  String? description;
  String? imageURL;
  bool? isActive;
  bool? isLimit;
  bool? isRemoved;
  DateTime? createdAt;
  DateTime? updatedAt;

}

@jsonSerializable
class ItemApiModel {
  String? id;
  String? name;
  int? price;
  bool? isLimit;
  int? quantity;
  int? orignialQuantity;
  DateTime? createdAt;
  DateTime? updatedAt;

}
