import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/domain/repositories/menu_repo.dart';

class GetMenuUseCase extends UseCaseIO<GetMenuParams, List<Menu>?> {
  final MenuTodayRepo _menuTodayRepo;

  GetMenuUseCase(this._menuTodayRepo);
  @override
  Future<List<Menu>?> build(GetMenuParams input) {
    return _menuTodayRepo.getMenuToday(input.category,input.branchId);
  }
}
class GetMenuParams {
  final String category;
  final String branchId;

  GetMenuParams({required this.category, required this.branchId});
}
