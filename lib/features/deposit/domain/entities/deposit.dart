import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Deposit with PrettyJsonMixin {
  String? paymentURL = '';
  String? trxRefNo = '';
  String? userId = '';
  String? email = '';
  int? point = 0;
}
