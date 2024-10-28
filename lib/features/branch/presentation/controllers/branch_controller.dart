import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/branch/domain/usecases/get_branch_uc.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:get/get.dart';

class BranchController extends BaseController {
  GetBranchUseCase get _getBranchUsecase => Get.find<GetBranchUseCase>();

  BaseState<List<Branch>?> getBranchsState = BaseState();
  final LocalStorage _localStorage = Get.find();
  final selectedBranch = Rxn<Branch>(); // Observable for selected branch

  @override
  void onInit() async {
    super.onInit();
    getBranches();
  }

  @override
  void onClose() {
    _getBranchUsecase.dispose();
    super.onClose();
  }

  Future<void> getBranches() {
    return _getBranchUsecase.execute(
      observer: Observer(
        onSubscribe: () {
          getBranchsState.onLoading();
        },
        onSuccess: (List<Branch>? branches) {
          getBranchsState.onSuccess(data: branches);
        },
        onError: (AppException e) {
          getBranchsState.onError(e.message);
          handleError(e);
        },
      ),
      input: null,
    );
  }

  void selectBranch(Branch branch) {
    selectedBranch.value = branch;
    // _localStorage.saveSelectedBranch(branch); // Save selected branch if needed
  }

  void setAccessToken() {
    _localStorage.saveAccessToken('accessToken123123123');
  }

  void setRefreshToken() {
    _localStorage.saveUserRefreshToken('refreshToken123123123');
  }

  void clearAllData() {
    _localStorage.removeAllData();
  }

  void logout() {
    Get.find<AuthService>().logout();
  }

  void printIcons() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('icons/'))
        .where((String key) => key.contains('.svg'))
        .toList();
    L.debug(imagePaths);
  }

  void switchTheme() {
    final newThemeMode = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _localStorage.saveThemeMode(newThemeMode);
    Get.changeThemeMode(newThemeMode);
  }
}
