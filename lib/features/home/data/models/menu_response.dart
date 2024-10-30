import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/features/branch/data/models/branch_response.dart';

@jsonSerializable
class MenuResponse extends BaseResponse {
  List<MenuApiModel>? data = [];
}

@jsonSerializable
class MenuApiModel {
  String? id = '';
  String? branchId = '';
  int? quantity = 0;
  int? orignialQuantity = 0;
  int? orderedQuantity = 0;
  String? status = '';
  String? menu = '';
  String? dateSale = '';
  String? createdAt = '';
  bool? isRemoved = false;
  int? sortOrder = 0;
  String? updatedAt = '';
  ProductApiModel? product = ProductApiModel();
  String? _type;
  String get type => _type ?? '';
  set type(String? value) => _type = value;
  BranchApiModel? branch = BranchApiModel();
  List<ItemApiModel>? items = [];
}

@jsonSerializable
class ProductApiModel {
  String? id = '';
  String? name = '';
  String? description = '';
  String? imageURL = '';
  bool? isActive = false;
  bool? isLimit = false;
  bool? isRemoved = false;
  String? createdAt = '';
  String? updatedAt = '';
}

@jsonSerializable
class ItemApiModel {
  String? id = '';
  String? name = '';
  int? price = 0;
  bool? isLimit = false;
  int? quantity = 0;
  int? orignialQuantity = 0;
  String? createdAt = '';
  String? updatedAt = '';
}
