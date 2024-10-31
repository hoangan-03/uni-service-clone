import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';
import 'package:flutter_base_v2/features/home/domain/entities/item.dart';
import 'package:flutter_base_v2/features/home/domain/entities/product.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu_type.dart';

@jsonSerializable
class Menu with PrettyJsonMixin {
  String id = '';
  String branchId = '';
  int quantity = 0;
  int orignialQuantity = 0;
  int orderedQuantity = 0;
  String status = '';
  String menu = '';
  MenuType type = MenuType();
  Product product = Product();
  @JsonProperty(name: 'items')
  List<Item>? items;
  
}
