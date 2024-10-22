import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class BaseResponse with PrettyJsonMixin {
  int? code;
  String? message;
  List<ErrorField>? errors;
}

@jsonSerializable
class Pagination with PrettyJsonMixin {
  int? limit;
  int? page;
  int? totalRows;
}

@jsonSerializable
class ErrorField {
  String? code;

  String? field;

  String? message;
}
