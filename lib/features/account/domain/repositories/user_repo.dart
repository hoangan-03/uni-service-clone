import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/features/account/data/models/request/change_password_request.dart';
import 'package:flutter_base_v2/features/account/data/models/response/user.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'dart:io';

abstract class UserRepo extends BaseMappingRepo<User, UserApiModel> {
  Future<User?> getUserProfile();
  Future<void> updateProfile(User user);
  Future<void> updateAvatar(File avatar);
  Future<void> updatePassword(ChangePasswordRequest request);
}
