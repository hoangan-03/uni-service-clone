import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';

@jsonSerializable
class UserResponse extends BaseResponse {
  UserApiModel? data;
}

@jsonSerializable
class UserApiModel {
  String? id;
  @JsonProperty(name: 'username')
  String? userName;
  String? email;
}
