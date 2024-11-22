
import 'package:flutter_base_v2/features/authentication/data/models/token_model.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/getOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/login_body.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/update_info.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/verifyOTP_body.dart';

abstract class AuthRepo {

  Future<void> getOTP(GetOTPBody request);

  Future<TokenModel> verifyOTP(VerifyOTPBody request);

  Future<void> updateInfo(UpdateInfoBody request);

  Future<void> loginWithEmail(LoginBody request);

  Future<void> loginWithGoogle();

  Future<void> loginWithApple();

  Future<void> logout();

}
