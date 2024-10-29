import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/home/data/models/menu_response.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/domain/repositories/menu_repo.dart';
import 'package:flutter_base_v2/features/home/domain/entities/item.dart';

class MenuRepoImpl extends MenuRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<List<Menu>?> getMenus(String category, String branchId) async {
    final response = await _apiService.getMenu(category, branchId);
    final List<MenuApiModel>? menuModels = response.data;

    return menuModels?.map((model) => _mapMenuApiModelToMenu(model)).toList();
  }

  Menu _mapMenuApiModelToMenu(MenuApiModel model) {
    return Menu(
      id: model.id ?? '',
      branchId: model.branchId ?? '',
      quantity: model.quantity ?? 0,
      orignialQuantity: model.orignialQuantity ?? 0,
      orderedQuantity: model.orderedQuantity ?? 0,
      status: model.status ?? '',
      menu: model.menu ?? '',
      items: model.items != null
          ? model.items!.map((item) => _mapItemApiModelToItem(item)).toList()
          : [],
    );
  }

  Item _mapItemApiModelToItem(ItemApiModel itemModel) {
    return Item(
      id: itemModel.id ?? '',
      name: itemModel.name ?? '',
      price: itemModel.price ?? 0,
      isLimit: itemModel.isLimit ?? false,
      quantity: itemModel.quantity ?? 0,
      orignialQuantity: itemModel.orignialQuantity ?? 0,
    );
  }
}
