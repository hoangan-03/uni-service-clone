import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/authentication/data/models/token_model.dart';
import 'package:flutter_base_v2/features/authentication/data/models/token_response.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/getOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/login_body.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/update_info.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/verifyOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/repositories/auth_repo.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepoImpl extends AuthRepo {
  final LocalStorage _localStorage = Get.find();
  final ApiService _apiService = Get.find();
  final GoogleSignIn _googleSignIn = Get.find();

  @override
  Future<void> loginWithEmail(LoginBody request) async {
    TokenResponse response = await _apiService.loginWithEmail(request);
    if (response.data?.accessToken == null) {
      throw AppException(
          AppExceptionType.unauthorized, 'Invalid access token!');
    }
    _localStorage.saveUserTokenData(response.data);
  }

  @override
  Future<void> updateInfo(UpdateInfoBody request) {
// todo
    throw UnimplementedError();
  }
    @override
  Future<void> getOTP(GetOTPBody request) {
// todo
    throw UnimplementedError();
  }
    @override
  Future<TokenModel> verifyOTP(VerifyOTPBody request) {
// todo
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    await _apiService.logout();
  }

  @override
  Future<void> loginWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication auth = await googleAccount!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    print('loginWithGoogle idToken $idToken');
    // TODO send to BE
    print('sub1 ${idToken?.substring(0, 1000)}');
    print('sub2 ${idToken?.substring(995, idToken.length)}');
  }

  @override
  Future<void> loginWithApple() async {
    final AuthorizationCredentialAppleID appleCredential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId: 'com.service.flutterBaseV2.stg',
        redirectUri: Uri.parse(
                    'https://utopian-western-brace.glitch.me/callbacks/sign_in_with_apple',
                  ),
      ),
    );
    final OAuthCredential oAuthCredential = OAuthProvider('apple.com')
        .credential(
            accessToken: appleCredential.authorizationCode,
            idToken: appleCredential.identityToken);
    await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    print('loginWithApple idToken $idToken');
    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
    final length = idToken!.length;
    print('sub1 ${idToken.substring(0, 1000)}');
    print('sub2 ${idToken.substring(995, length)}');
  }
}
