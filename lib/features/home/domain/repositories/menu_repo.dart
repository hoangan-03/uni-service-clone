import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/home/data/models/menu_response.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';


abstract class MenuRepo extends BaseMappingRepo<List<Menu>,List<MenuApiModel> > {
  Future<List<Menu>?> getMenus(String category, String branchId);
}