import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Transfer with PrettyJsonMixin {
  String? id = '';
  String? username = '';
  String? phone  = '';
  String? avatar = '';
  String? email = '';
}
