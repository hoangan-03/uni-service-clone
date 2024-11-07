import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/account/data/models/user_response.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/account/domain/repositories/user_repo.dart';
import 'package:get/get.dart';

class UserRepoImpl extends UserRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<User?> getUserProfile() async {
    final UserResponse response = await _apiService.getUserProfile();
    final UserApiModel? model = response.data;
    return (model != null) ? mappingEntity(model) : null;
  }
}