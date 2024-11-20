import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_response.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer.dart';

abstract class TransferRepo extends BaseMappingRepo<Transfer, TransferApiModel> {
  Future<Transfer> transferRequest(String recipientId, int amount);
}
