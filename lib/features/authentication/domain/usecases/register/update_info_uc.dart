import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/update_info.dart';
import 'package:flutter_base_v2/features/authentication/domain/repositories/auth_repo.dart';

class UpdateInfoUsecase extends UseCaseIO<UpdateInfoBody, void> {
  final AuthRepo _authRepo;

  UpdateInfoUsecase(this._authRepo);

  @override
  Future<void> build(UpdateInfoBody input) {
    return _authRepo.updateInfo(input);
  }
}


