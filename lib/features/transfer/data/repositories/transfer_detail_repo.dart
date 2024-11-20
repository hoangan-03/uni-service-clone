import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_detail_reponse.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer_detail.dart';
import 'package:flutter_base_v2/features/transfer/domain/repositories/transfer_detail_repo.dart';

class TransferDetailRepoImpl extends TransferDetailRepo {
  final ApiService _apiService = Get.find();
  @override
  Future<TransferDetail?> getTransferDetail(String txn) async {
    final TransferDetailResponse response = await _apiService.getTransferDetail(txn);
    final TransferDetailApiModel model = response.data;
    return mappingEntity(model);
  }
}
