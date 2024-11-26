import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/home/data/models/response/menu_response.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/domain/repositories/menu_repo.dart';

class MenuRepoImpl extends MenuTodayRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<List<Menu>?> getMenuToday(String category, String branchId) async {
    final response = await _apiService.getMenuToday(category, branchId);
    final List<MenuApiModel>? menuModels = response.data;

     return (menuModels != null) ? mappingEntity(menuModels) : null;
  }
}
