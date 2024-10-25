
import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/home/data/repositories/branch_repo.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';

class GetBranchUseCase extends UseCaseIO<void, Branch?> {
  final BranchRepo _branchRepo;

  GetBranchUseCase(this._branchRepo);

  @override
  Future<Branch?> build(void input) {
    return _branchRepo.getListBrands().then((branches) => branches?.first);
  }
}
