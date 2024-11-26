import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/order/data/models/response/menu_qr.dart';
import 'package:flutter_base_v2/features/order/data/models/response/menu_qr_response.dart';
import 'package:flutter_base_v2/features/order/domain/entities/menu_qr.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/qr_repo.dart';

class QrCodeRepoImpl extends QrCodeRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<MenuQR?> getQrCode(String productId) async {
    final MenuQRResponse response = await _apiService.getQrCode(productId);
    final MenuQRApiModel model = response.data;
    return mappingEntity(model);
  }
}
