import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Item with PrettyJsonMixin {
  String id = '';
  String name = '';
  int price = 0;
  bool isLimit = false;
  bool isActive = true;
  int quantity = 0;
  int orignialQuantity = 0;
  String description = '';

  Item({
    required this.id,
    this.name = '',
    this.price = 0,
    this.isLimit = false,
    this.quantity = 0,
    this.orignialQuantity = 0,
    this.description = '', 
    this.isActive = true,
  });

}
