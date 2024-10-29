import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Product with PrettyJsonMixin {
  String id = '';
  String name = '';
  String description = '';
  String imageURL = '';
  bool isActive = true;
  bool isLimit = false;

  Product({
    required this.id,
    required this.name,
    required this.isLimit,
    required this.imageURL,
    required this.isActive,
    this.description = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageURL: json['imageURL'],
      isActive: json['isActive'],
      isLimit: json['isLimit'],
    );
  }
}
