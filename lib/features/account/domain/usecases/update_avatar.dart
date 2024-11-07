import 'dart:io';

import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/account/domain/repositories/user_repo.dart';

class UpdateAvatarUseCase extends UseCaseIO<File, void> {
  final UserRepo _profileRepo;

  UpdateAvatarUseCase(this._profileRepo);

  @override
  Future<void> build(File input) {
    return _profileRepo.updateAvatar(input);
  }
}