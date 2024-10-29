import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/domain/repositories/menu_repo.dart';

class GetMenuUseCase extends UseCaseIO<GetMenuParams, List<Menu>?> {
  final MenuRepo _menuRepo;

  GetMenuUseCase(this._menuRepo);

  @override
  Future<List<Menu>?> build(GetMenuParams input) {
    return _menuRepo.getMenu(input.category, input.branchId);
  }
}

class GetMenuParams {
  final String category;
  final String branchId;

  GetMenuParams({required this.category, required this.branchId});
}
