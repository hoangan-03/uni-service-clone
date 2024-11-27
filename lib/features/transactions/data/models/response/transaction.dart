import 'package:dart_json_mapper/dart_json_mapper.dart';

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