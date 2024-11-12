import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/order/data/models/menu_qr_response.dart';
import 'package:flutter_base_v2/features/order/domain/entities/menu_qr.dart';

abstract class QrCodeRepo extends BaseMappingRepo<MenuQR, MenuQRApiModel> {
  Future<MenuQR?> getQrCode(String productId);
}
