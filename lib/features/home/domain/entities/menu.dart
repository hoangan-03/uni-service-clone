import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';
import 'package:flutter_base_v2/features/branch/domain/entities/branch.dart';
import 'package:flutter_base_v2/features/home/domain/entities/item.dart';
import 'package:flutter_base_v2/features/home/domain/entities/product.dart';

@jsonSerializable
class Menu with PrettyJsonMixin {
  String id = '';
  String branchId = '';
  int quantity = 0;
  int orignialQuantity = 0;
  int orderedQuantity = 0;
  String status = '';
  String menu = '';
  Branch? branch;
  List<Item> items = [];
  Product? product;

  Menu({
    required this.id,
    required this.branchId,
    required this.quantity,
    required this.orignialQuantity,
    required this.orderedQuantity,
    required this.status,
    required this.menu,
    this.branch,
    required this.items,
    this.product,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      branchId: json['branchId'],
      quantity: json['quantity'],
      orignialQuantity: json['orignialQuantity'],
      orderedQuantity: json['orderedQuantity'],
      status: json['status'],
      menu: json['menu'],
      branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
      items: List<Item>.from(json['items'].map((item) => Item.fromJson(item))), 
      product: Product.fromJson(json['product']),
    );
  }
}
