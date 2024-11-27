import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/branch/data/models/response/branch.dart';
import 'package:flutter_base_v2/features/branch/domain/entities/branch.dart';


abstract class BranchRepo extends BaseMappingRepo<Branch, BranchApiModel> {
  Future<List<Branch>?> getListBrands();
}