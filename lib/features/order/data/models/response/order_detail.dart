import 'package:dart_json_mapper/dart_json_mapper.dart';

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