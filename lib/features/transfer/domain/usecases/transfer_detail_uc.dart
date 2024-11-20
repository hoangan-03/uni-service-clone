import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer_detail.dart';
import 'package:flutter_base_v2/features/transfer/domain/repositories/transfer_detail_repo.dart';

class TransferDetailUseCase
    extends UseCaseIO<TransferDetailParams, TransferDetail?> {
  final TransferDetailRepo _transferDetailRepo;

  TransferDetailUseCase(this._transferDetailRepo);

  @override
  Future<TransferDetail?> build(TransferDetailParams input) {
    return _transferDetailRepo.getTransferDetail(input.txn ?? '');
  }
}

class TransferDetailParams {
  final String? txn;

  TransferDetailParams({this.txn});
}
