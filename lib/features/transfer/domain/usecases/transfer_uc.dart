import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_request.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer.dart';
import 'package:flutter_base_v2/features/transfer/domain/repositories/transfer_repo.dart';

class TransferRequestUseCase extends UseCaseIO<TransferRequest, Transfer> {
  final TransferRepo _transferRepo;

  TransferRequestUseCase(this._transferRepo);

  @override
  Future<Transfer> build(TransferRequest input) {
    return _transferRepo.transferRequest(input.recipientId, input.amount);
  }
}
