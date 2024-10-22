
import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class User with PrettyJsonMixin{
  String id = '';
  @JsonProperty(name: 'username')
  String name = '';
  String email = '';
}
