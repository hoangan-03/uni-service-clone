import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/authentication/data/models/response/token_model.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/verifyOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/repositories/auth_repo.dart';

class VerifyOtpUsecase extends UseCaseIO<VerifyOTPBody, TokenModel> {
  final AuthRepo _authRepo;

  VerifyOtpUsecase(this._authRepo);

  @override
  Future<TokenModel> build(VerifyOTPBody input) {
    return _authRepo.verifyOTP(input);
  }
}


