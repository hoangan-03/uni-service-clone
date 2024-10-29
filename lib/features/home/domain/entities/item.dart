import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Item with PrettyJsonMixin {
  String id = '';
  String name = '';
  int price = 0;
  bool isLimit = false;
  int quantity = 0;
  int orignialQuantity = 0;
  String description = '';

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.isLimit,
    required this.quantity,
    required this.orignialQuantity,
    this.description = '',
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      isLimit: json['isLimit'],
      quantity: json['quantity'],
      orignialQuantity: json['orignialQuantity'],
      description: json['description'],
    );
  }
}
