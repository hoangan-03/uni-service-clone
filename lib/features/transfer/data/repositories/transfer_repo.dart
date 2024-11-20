import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_request.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_response.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer.dart';
import 'package:flutter_base_v2/features/transfer/domain/repositories/transfer_repo.dart';

class TransferRepoImpl extends TransferRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<Transfer> transferRequest(String recipientId, int amount) async {
    final request = TransferRequest(
      recipientId: recipientId,
      amount: amount,
    );
    final TransferResponse response =
        await _apiService.transferRequest(request);
    final TransferApiModel model = response.data;
    return mappingEntity(model);
  }
}
