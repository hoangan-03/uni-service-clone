import 'package:dart_json_mapper/dart_json_mapper.dart';

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