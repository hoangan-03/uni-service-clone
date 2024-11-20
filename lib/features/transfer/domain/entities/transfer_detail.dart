import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_detail_reponse.dart';

@jsonSerializable
class TransferDetail with PrettyJsonMixin {
  String? id = '';
  int? amount = 0;
  String? status = '';
  RecipientSender recipient = RecipientSender();
  RecipientSender sender = RecipientSender();
}
