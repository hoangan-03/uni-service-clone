import 'package:flutter_base_v2/base/domain/base_usecase.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/getOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/repositories/auth_repo.dart';

class GetOtpUsecase extends UseCaseIO<GetOTPBody, void> {
  final AuthRepo _authRepo;

  GetOtpUsecase(this._authRepo);

  @override
  Future<void> build(GetOTPBody input) {
    return _authRepo.getOTP(input);
  }
}


