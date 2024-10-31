import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class MenuType with PrettyJsonMixin {
  String? id = '';
  String? name = '';
  int? price = 0;
  String? createdAt = '';
  String? updatedAt = '';
}
