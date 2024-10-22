import 'package:flutter_base_v2/base/data/models/common/base_response.dart';
import 'package:flutter_base_v2/base/data/models/pretty_json_mixin.dart';

@jsonSerializable
class HistoryPaging with PrettyJsonMixin {
  @JsonProperty(name: 'data')
  List<History>? histories;
  @JsonProperty(name: 'paginate')
  Pagination? pagination;
}

@jsonSerializable
class History with PrettyJsonMixin {
  String? id;
  String? type;
}
