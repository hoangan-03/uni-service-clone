import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class TypeApiModel {
  String? id = '';
  String? name = '';
  int? price = 0;
  String? createdAt = '';
  String? updatedAt = '';
}