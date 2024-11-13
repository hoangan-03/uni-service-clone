import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class Transaction with PrettyJsonMixin {
  Transaction({
    required this.id,
    this.type,
    this.userId,
    this.staffId,
    this.staffName,
    this.userName,
    this.userPhone,
    this.studentId,
    this.studentCode,
    this.status,
    this.point,
    this.transactionId,
    this.relationId,
    this.createdAt,
    this.updatedAt,
    this.userEmail,
  });

  String id;
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

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      type: json['type'] as String?,
      userId: json['userId'] as String?,
      staffId: json['staffId'] as String?,
      staffName: json['staffName'] as String?,
      userName: json['userName'] as String?,
      userPhone: json['userPhone'] as String?,
      studentId: json['studentId'] as String?,
      studentCode: json['studentCode'] as String?,
      status: json['status'] as String?,
      point: json['point'] as int?,
      transactionId: json['transactionId'] as String?,
      relationId: json['relationId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      userEmail: json['userEmail'] as String?,
    );
  }
}