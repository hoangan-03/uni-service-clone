import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class BranchApiModel {
  String? id;
  @JsonProperty(name: 'name')
  String? name;
  String? description;
  bool? isActive;
}