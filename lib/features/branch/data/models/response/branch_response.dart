import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';

@jsonSerializable
class BranchResponse extends BaseResponse {
  List<BranchApiModel>? data; 
}

@jsonSerializable
class BranchApiModel {
  String? id;
  @JsonProperty(name: 'name')
  String? name;
  String? description;
  bool? isActive;
}
