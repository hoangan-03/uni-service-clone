import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/branch/domain/repositories/branch_repo.dart';
import 'package:flutter_base_v2/features/branch/domain/entities/branch.dart';

class GetBranchUseCase extends UseCaseIO<void, List<Branch>?> {
  final BranchRepo _branchRepo;

  GetBranchUseCase(this._branchRepo);

  @override
  Future<List<Branch>?> build(void input) {
    return _branchRepo.getListBrands();
  }
}
