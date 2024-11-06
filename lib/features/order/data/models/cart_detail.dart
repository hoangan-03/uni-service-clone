import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class CartDetail {
  String? idMenu = '';
  int? quantity = 0;
  int? price = 0;
  bool? isLimit = false;
  int? quantityInStock = 0;
  String? name = '';
  String? description = '';
  String? imageURL = '';
}