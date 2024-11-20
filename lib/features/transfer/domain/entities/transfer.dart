import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Transfer with PrettyJsonMixin {
  String? txn = '';
  int? fee = 0;
  int? amount = 0;
}
