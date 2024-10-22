import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class HistoryResponse extends BaseResponse with PrettyJsonMixin {
  @JsonProperty(name: 'data')
  HistoryPagingApiModel? historyPaging;
}

@jsonSerializable
class HistoryPagingApiModel with PrettyJsonMixin {
  @JsonProperty(name: 'data')
  List<HistoryApiModel>? histories;
  @JsonProperty(name: 'paginate')
  Pagination? pagination;
}

@jsonSerializable
class HistoryApiModel with PrettyJsonMixin {
  String? id;
  String? type;
}
