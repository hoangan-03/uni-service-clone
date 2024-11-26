import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/home/data/models/response/menu_response.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';


abstract class MenuTodayRepo extends BaseMappingRepo<List<Menu>,List<MenuApiModel> > {
  Future<List<Menu>?> getMenuToday(String category, String branchId);
}