import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/history/data/models/response/transaction_response.dart';
import 'package:flutter_base_v2/features/history/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/history/domain/repositories/transaction_repo.dart';

class TransactionRepoImpl extends TransactionRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<List<Transaction>?> getUserHistory(int page, int limit, String order,
      String field, String fromDate, String toDate) async {
    final response = await _apiService.getUserHistory(
        page, limit, order, field, fromDate, toDate);
    final List<TransactionApiModel>? apiModels = response.data?.data;
    return apiModels?.map((model) => mappingEntity(model)).toList();
  }

  @override
  Future<List<Transaction>?> getUserHistoryByCategory(
      int page,
      int limit,
      String order,
      String transactionType,
      String field,
      String fromDate,
      String toDate) async {
    final response = await _apiService.getUserHistoryByCategory(
        page, limit, order, transactionType, field, fromDate, toDate);
    final List<TransactionApiModel>? apiModels = response.data?.data;
    return apiModels?.map((model) => mappingEntity(model)).toList();
  }

  @override
  Transaction mappingEntity(TransactionApiModel model) {
    return Transaction(
      id: model.id!,
      type: model.type,
      userId: model.userId,
      staffId: model.staffId,
      staffName: model.staffName,
      userName: model.userName,
      userPhone: model.userPhone,
      studentId: model.studentId,
      studentCode: model.studentCode,
      status: model.status,
      point: model.point,
      transactionId: model.transactionId,
      relationId: model.relationId,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      userEmail: model.userEmail,
    );
  }
}
