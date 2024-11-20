import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_detail_reponse.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer_detail.dart';

abstract class TransferDetailRepo extends BaseMappingRepo<TransferDetail, TransferDetailApiModel> {
  Future<TransferDetail?> getTransferDetail(String txn);
}