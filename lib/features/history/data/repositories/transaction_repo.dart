
import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/history/data/models/transaction_response.dart';
import 'package:flutter_base_v2/features/history/domain/entities/transaction.dart';
import 'package:flutter_base_v2/features/history/domain/repositories/transaction_repo.dart';

class TransactionRepoImpl extends TransactionRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<List<Transaction>?> getUserHistory(int page, int limit, String order, String field, String fromDate, String toDate) async {
    final response = await _apiService.getUserHistory(page, limit, order, field, fromDate, toDate);
    final List<TransactionApiModel>? apiModels = response.data; 
    return apiModels?.map((model) => mappingEntity(model)).toList();
  }
}
