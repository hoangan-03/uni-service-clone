import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/login_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/repositories/auth_repo.dart';

class LoginWithEmailUseCase extends UseCaseIO<LoginBody, void> {
  final AuthRepo _authRepo;

  LoginWithEmailUseCase(this._authRepo);

  @override
  Future<void> build(LoginBody input) {
    return _authRepo.loginWithEmail(input);
  }
}

class LoginWithGoogleUseCase extends UseCase<void> {
  final AuthRepo _authRepo;

  LoginWithGoogleUseCase(this._authRepo);

  @override
  Future<void> build() {
    return _authRepo.loginWithGoogle();
  }
}

class LoginWithAppleUseCase extends UseCase<void> {
  final AuthRepo _authRepo;

  LoginWithAppleUseCase(this._authRepo);

  @override
  Future<void> build() {
    return _authRepo.loginWithApple();
  }
}
