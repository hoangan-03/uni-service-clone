import 'package:dio/dio.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class FormData {
  @JsonProperty(name: 'avatar')
  final MultipartFile avatar;

  FormData({required this.avatar});
}