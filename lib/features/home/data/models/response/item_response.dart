import 'package:dart_json_mapper/dart_json_mapper.dart';

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