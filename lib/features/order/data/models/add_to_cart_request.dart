import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class AddToCartRequest {
  String idProduct = '';
  int quantity = 0;
  AddToCartRequest({
    required this.idProduct,
    required this.quantity,
  });
}
