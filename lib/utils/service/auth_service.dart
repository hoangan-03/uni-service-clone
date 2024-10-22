import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/authentication/domain/repositories/auth_repo.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthServiceType { google, apple }

abstract class AuthService extends GetxService {
  Future<bool> isAuthenticated();
  Future<void> logout();
  void onUnauthorized() {}
}

class AppAuthService extends AuthService {
  final LocalStorage _localStorage = Get.find();

  @override
  Future<bool> isAuthenticated() async {
    return await _localStorage.accessToken != null;
  }

  @override
  Future<void> logout() async {
    if (await isAuthenticated()) {
      await Get.find<AuthRepo>().logout();
    }
    await _localStorage.removeAllData();
    N.toLandingPage();
  }

  @override
  void onUnauthorized() async {
    super.onUnauthorized();
    await _localStorage.removeAllData();
    N.toLandingPage();
  }
}

class GoogleAuthService extends AuthService {
  final GoogleSignIn _googleSignIn = Get.find();

  @override
  Future<bool> isAuthenticated() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.disconnect();
  }
}
