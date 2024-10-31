import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Branch with PrettyJsonMixin {
  Branch();

  String id = '';
  @JsonProperty(name: 'name')
  String name = '';
  String? description;
  bool isActive = false;

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch()
      ..id = json['id'] as String
      ..name = json['name'] as String
      ..description = json['description'] as String? 
      ..isActive = json['isActive'] as bool;
  }
}