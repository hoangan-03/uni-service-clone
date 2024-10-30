import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Item with PrettyJsonMixin {
  String id = '';
  String name = '';
  int price = 0;
  bool isLimit = false;
  int quantity = 0;
  int orignialQuantity = 0;
}
