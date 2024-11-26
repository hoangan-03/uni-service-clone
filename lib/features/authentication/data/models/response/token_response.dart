
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/features/authentication/data/models/response/token_model.dart';

@jsonSerializable
class TokenResponse extends BaseResponse {
  TokenModel? data;
}
