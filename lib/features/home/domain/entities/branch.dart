import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Branch with PrettyJsonMixin{
  String id = '';
  @JsonProperty(name: 'name')
  String name = '';
  String description = '';
  bool isActive = false;
}