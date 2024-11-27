import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/features/transactions/data/models/response/transaction.dart';

@jsonSerializable
class TransactionResponse extends BaseResponse {
   TransactionData? data;
}
@jsonSerializable
class TransactionData {
  List<TransactionApiModel>? data;
}
