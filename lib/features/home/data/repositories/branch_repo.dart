import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/home/data/models/branch_response.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';

abstract class BranchRepo extends BaseMappingRepo<Branch, BranchApiModel> {
  Future<List<Branch>?> getListBrands();
}

class BranchRepoImpl extends BranchRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<List<Branch>?> getListBrands() async {
    final response = await _apiService.getListBrands();
    final List<BranchApiModel>? apiModels = response.data; 
    return apiModels?.map((model) => mappingEntity(model)).toList();
  }
}
