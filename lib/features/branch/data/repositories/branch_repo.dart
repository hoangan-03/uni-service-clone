import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/branch/data/models/response/branch_response.dart';
import 'package:flutter_base_v2/features/branch/domain/repositories/branch_repo.dart';
import 'package:flutter_base_v2/features/branch/domain/entities/branch.dart';

class BranchRepoImpl extends BranchRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<List<Branch>?> getListBrands() async {
    final response = await _apiService.getListBrands();
    final List<BranchApiModel>? apiModels = response.data; 
    return apiModels?.map((model) => mappingEntity(model)).toList();
  }
}
