import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';

@jsonSerializable
class TransactionResponse extends BaseResponse {
   TransactionData? data;
}
@jsonSerializable
class TransactionData {
  List<TransactionApiModel>? data;
}
@jsonSerializable
class TransactionApiModel {
  String? id;
  String? type;
  String? userId;
  String? staffId;
  String? staffName;
  String? userName;
  String? userPhone;
  String? studentId;
  String? studentCode;
  String? status;
  int? point;
  String? transactionId;
  String? relationId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userEmail;
}