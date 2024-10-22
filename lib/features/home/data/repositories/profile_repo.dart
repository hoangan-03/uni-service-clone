import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/authentication/data/models/user_response.dart';
import 'package:flutter_base_v2/features/home/domain/entities/user.dart';

abstract class ProfileRepo extends BaseMappingRepo<User, UserApiModel> {
  Future<User?> getProfile();
}

class ProfileRepoImpl extends ProfileRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<User?> getProfile() async {
    final UserResponse response = await _apiService.getProfile();
    final UserApiModel? model = response.data;
    return (model != null) ? mappingEntity(model) : null;
  }
}
