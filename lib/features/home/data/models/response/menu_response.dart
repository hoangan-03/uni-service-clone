import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/features/branch/data/models/response/branch_response.dart';
import 'package:flutter_base_v2/features/home/data/models/response/item_response.dart';
import 'package:flutter_base_v2/features/home/data/models/response/product_response.dart';
import 'package:flutter_base_v2/features/home/data/models/response/type_response.dart';

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
  TypeApiModel? _type;

  TypeApiModel get type => _type ?? TypeApiModel();
  set type(TypeApiModel? value) => _type = value;

  BranchApiModel? branch = BranchApiModel();
  @JsonProperty(name: 'items')
  List<ItemApiModel>? items;
}




