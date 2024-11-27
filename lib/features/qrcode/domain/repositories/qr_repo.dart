import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/qrcode/data/models/response/menu_qr.dart';
import 'package:flutter_base_v2/features/qrcode/domain/entities/menu_qr.dart';

abstract class QrCodeRepo extends BaseMappingRepo<MenuQR, MenuQRApiModel> {
  Future<MenuQR?> getQrCode(String productId);
}
