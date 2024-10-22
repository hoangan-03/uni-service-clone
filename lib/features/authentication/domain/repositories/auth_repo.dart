
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/login_body.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/register_body.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepo {
  Future<void> registerWithEmail(RegisterBody request);

  Future<void> loginWithEmail(LoginBody request);

  Future<void> loginWithGoogle();

  Future<void> loginWithApple();

  Future<void> logout();

}
