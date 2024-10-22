import 'package:flutter_base_v2/base/data/base_mapper.dart';
import 'package:get/get.dart';

export 'package:get/instance_manager.dart';
export '../data/local/local_storage.dart';

abstract class BaseMappingRepo<Entity, Model> extends GetxService {
  final mapper = BaseMapper<Entity, Model>();

  Entity mappingEntity(Model model) {
    return mapper.mappingEntity(model);
  }

  Model mappingModel(Entity entity) {
    return mapper.mappingModel(entity);
  }
}


