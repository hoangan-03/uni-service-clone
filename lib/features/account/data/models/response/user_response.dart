import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/features/account/data/models/response/user.dart';

@jsonSerializable
class UserResponse extends BaseResponse {
  UserApiModel data = UserApiModel();
}

