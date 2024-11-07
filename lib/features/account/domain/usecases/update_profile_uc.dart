import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/account/domain/repositories/user_repo.dart';

class UpdateProfileUseCase extends UseCaseIO<User, void> {
  final UserRepo _profileRepo;

  UpdateProfileUseCase(this._profileRepo);

  @override
  Future<void> build(User input) {
    return _profileRepo.updateProfile(input);
  }
}