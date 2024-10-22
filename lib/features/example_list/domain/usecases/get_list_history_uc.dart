import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/example_list/data/repositories/history_repo.dart';
import 'package:flutter_base_v2/features/example_list/domain/entities/history_paging.dart';

class GetListHistoryUseCase extends UseCaseIO<int, HistoryPaging?> {
  final HistoryRepo _historyRepo;

  GetListHistoryUseCase(this._historyRepo);

  @override
  Future<HistoryPaging?> build(int input) {
    return _historyRepo.getListHistory(input);
  }
}
