import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/account/data/models/request/change_password_request.dart';
import 'package:flutter_base_v2/features/account/domain/repositories/user_repo.dart';

class UpdatePasswordUseCase extends UseCaseIO<ChangePasswordRequest, void> {
  final UserRepo _profileRepo;

  UpdatePasswordUseCase(this._profileRepo);

  @override
  Future<void> build(ChangePasswordRequest input) {
    return _profileRepo.updatePassword(input);
  }
}