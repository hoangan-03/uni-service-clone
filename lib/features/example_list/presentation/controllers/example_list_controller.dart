import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/domain/dispose_bag.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common_paging_controller.dart';
import 'package:flutter_base_v2/features/example_list/domain/entities/history_paging.dart';
import 'package:flutter_base_v2/features/example_list/domain/usecases/get_list_history_uc.dart';
import 'package:flutter_base_v2/features/home/domain/entities/user.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:get/get.dart';

class ExampleListController extends BaseController {
  final fetchDataState = BaseState();

  GetListHistoryUseCase get _getListHistoryUseCase =>
      Get.find<GetListHistoryUseCase>();

  CommonPagingController<History> get pagingController => _pagingController;

  final _pagingController = CommonPagingController<History>();
  final _histories = <History>[];

  @override
  void onInit() {
    super.onInit();
    getExampleList(PagingConstants.initialPage);
    _pagingController.disposeBy(disposeBag);
    _pagingController.listen(
      onLoadMore: (nextPage) {
        getExampleList(nextPage);
      },
    );
  }

  Future<void> getExampleList(int page) {
    return _getListHistoryUseCase.execute(
      observer: Observer(
        onSubscribe: () {
          fetchDataState.onLoading();
        },
        onSuccess: (HistoryPaging? historyPaging) {
          fetchDataState.onSuccess();
          final List<History>? list = historyPaging?.histories;
          final Pagination? pagination = historyPaging?.pagination;
          if (list?.isNotEmpty == true) {
            _histories.addAll(list ?? []);
            _pagingController.appendLoadMoreOutput(
              LoadMoreOutput(list ?? [],
                  isRefreshSuccess: page == PagingConstants.initialPage,
                  isLastPage:
                      (pagination?.page ?? 0) * (pagination?.limit ?? 0) >=
                          (pagination?.totalRows ?? 0)),
            );
          }
        },
        onError: (AppException e) {
          fetchDataState.onError(e.message);
          // _showToastMessage(e.message);
        },
      ),
      input: page,
    );
  }

  Future<void> onRefresh() async {
    await getExampleList(PagingConstants.initialPage);
  }
}
