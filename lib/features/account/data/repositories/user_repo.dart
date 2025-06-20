
import 'dart:io';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/account/data/models/request/change_password_request.dart';
import 'package:flutter_base_v2/features/account/data/models/response/user.dart';
import 'package:flutter_base_v2/features/account/data/models/response/user_response.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/account/domain/repositories/user_repo.dart';
import 'package:get/get.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class FormData {
  @JsonProperty(name: 'avatar')
  final MultipartFile avatar;

  FormData({required this.avatar});
}

class UserRepoImpl extends UserRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<User?> getUserProfile() async {
    final UserResponse response = await _apiService.getUserProfile();
    final UserApiModel model = response.data;
    return mappingEntity(model);
  }

  @override
  Future<void> updateProfile(User user) async {
    final UserApiModel model = mappingModel(user);
    await _apiService.updateProfile(model);
  }

  @override
  Future<void> updateAvatar(File avatar) async {
    await _apiService.updateAvatar(avatar);
  }

    @override
  Future<void> updatePassword(ChangePasswordRequest request) async {
    await _apiService.updatePassword(request);
  }
}
