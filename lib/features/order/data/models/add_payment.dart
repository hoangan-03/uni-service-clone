import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class AddPaymentRequest {
  String cartId = '';
  AddPaymentRequest({
    required this.cartId,
  });
}
