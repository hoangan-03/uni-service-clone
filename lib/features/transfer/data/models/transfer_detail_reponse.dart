import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';

@jsonSerializable
class TransferDetailResponse extends BaseResponse {
  TransferDetailApiModel data = TransferDetailApiModel();
}

@jsonSerializable
class TransferDetailApiModel {
  String? id = '';
  String? amount = '';
  String? status = '';
  RecipientSender recipient = RecipientSender();
  RecipientSender sender = RecipientSender();

}
@jsonSerializable
class RecipientSender {
  String? id = '';
  String? username = '';
  String? phone  = '';
  String? avatar = '';
  String? email = '';
}

