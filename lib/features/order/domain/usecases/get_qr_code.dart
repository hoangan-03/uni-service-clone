import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/order/domain/entities/menu_qr.dart';
import 'package:flutter_base_v2/features/order/domain/repositories/qr_repo.dart';

class GetQrCodeUseCase extends UseCaseIO<GetQrCodeParams, MenuQR?> {
  final QrCodeRepo _qrCodeRepo;

  GetQrCodeUseCase(this._qrCodeRepo);
  @override
  Future<MenuQR?> build(GetQrCodeParams input) {
    return _qrCodeRepo.getQrCode(input.productId);
  }
}
class GetQrCodeParams {
  final String productId;

  GetQrCodeParams({required this.productId});
}
