
import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/home/data/repositories/profile_repo.dart';
import 'package:flutter_base_v2/features/home/domain/entities/user.dart';

class GetProfileUseCase extends UseCaseIO<void, User?> {
  final ProfileRepo _profileRepo;

  GetProfileUseCase(this._profileRepo);

  @override
  Future<User?> build(void input) {
    return _profileRepo.getProfile();
  }
}
