import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Product with PrettyJsonMixin {
  String id = '';
  String name = '';
  String description = '';
  String imageURL = '';
  bool isActive = true;
  bool isLimit = false;

}
