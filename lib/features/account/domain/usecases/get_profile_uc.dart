
import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/account/domain/repositories/user_repo.dart';

class GetProfileUseCase extends UseCaseIO<void, User?> {
  final UserRepo _profileRepo;

  GetProfileUseCase(this._profileRepo);

  @override
  Future<User?> build(void input) {
    return _profileRepo.getUserProfile();
  }
}
