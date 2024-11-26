import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';

@jsonSerializable
class DepositResponse extends BaseResponse {
  DepositApiModel data = DepositApiModel();
}

@jsonSerializable
class DepositApiModel {
  String? paymentURL = '';
  String? trxRefNo = '';
  String? userId = '';
  String? email = '';
  int? point = 0;
}
