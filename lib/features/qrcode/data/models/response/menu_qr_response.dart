import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/features/qrcode/data/models/response/menu_qr.dart';

@jsonSerializable
class MenuQRResponse extends BaseResponse {
  MenuQRApiModel data = MenuQRApiModel();
}
