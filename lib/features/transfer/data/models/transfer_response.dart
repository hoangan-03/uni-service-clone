import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';

@jsonSerializable
class TransferResponse extends BaseResponse {
  TransferApiModel data = TransferApiModel();
}

@jsonSerializable
class TransferApiModel {
  String? txn = '';
  int? fee = 0;
  int? amount = 0;
}
