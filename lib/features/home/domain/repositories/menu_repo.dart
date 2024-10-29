import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';


abstract class MenuRepo extends BaseMappingRepo<Menu, Menu> {
  Future<List<Menu>?> getMenu(String category, String branchId);
}