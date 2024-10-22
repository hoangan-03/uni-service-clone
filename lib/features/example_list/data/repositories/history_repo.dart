import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/example_list/data/models/history_response.dart';
import 'package:flutter_base_v2/features/example_list/domain/entities/history_paging.dart';

abstract class HistoryRepo
    extends BaseMappingRepo<HistoryPaging, HistoryPagingApiModel> {
  Future<HistoryPaging?> getListHistory(int page);
}

class HistoryRepoImpl extends HistoryRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<HistoryPaging?> getListHistory(int page) async {
    final HistoryResponse response = await _apiService.getListHistory(page);
    final HistoryPagingApiModel? apiModel = response.historyPaging;
    return (apiModel != null) ? mappingEntity(apiModel) : null;
  }
}
