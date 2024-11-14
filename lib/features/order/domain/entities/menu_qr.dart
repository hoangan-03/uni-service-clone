import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';
import 'package:flutter_base_v2/features/home/data/models/type_response.dart';
import 'package:flutter_base_v2/features/home/domain/entities/product.dart';

@jsonSerializable
class MenuQR with PrettyJsonMixin {
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
  Product? product = Product();
  TypeApiModel? _type;

  TypeApiModel get type => _type ?? TypeApiModel();
  set type(TypeApiModel? value) => _type = value;
}
