import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class TokenModel {
  @JsonProperty(name: 'access_token')
  String? accessToken;

  @JsonProperty(name: 'refresh_token')
  String? refreshToken;

  @JsonProperty(name: 'expires_in')
  int? expireIn;
}
