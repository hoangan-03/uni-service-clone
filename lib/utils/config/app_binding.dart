import 'package:dio/dio.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/base/data/remote/builder/dio_builder.dart';
import 'package:flutter_base_v2/features/authentication/data/repositories_impl/auth_repo_impl.dart';
import 'package:flutter_base_v2/features/authentication/domain/repositories/auth_repo.dart';
import 'package:flutter_base_v2/features/branch/domain/repositories/branch_repo.dart';
import 'package:flutter_base_v2/features/example_list/data/repositories/history_repo.dart';
import 'package:flutter_base_v2/features/home/data/repositories/profile_repo.dart';
import 'package:flutter_base_v2/features/branch/data/repositories/branch_repo.dart'; // Import BranchRepo
import 'package:flutter_base_v2/utils/config/app_config.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/instance_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectSnsProvider();
    injectStorageProvider();
    injectNetworkProvider();
    injectService();
    injectRepository();
  }

  void injectSnsProvider() {
    Get.lazyPut(() => GoogleSignIn());
  }

  void injectNetworkProvider() {
    Get.lazyPut(
      () => DioBuilder(
        ignoredToken: true,
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
      ),
      tag: DioBulderType.refresh.name,
      fenix: true,
    );
    Get.lazyPut(
      () => DioBuilder(
        ignoredToken: false,
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
        dioRefresh: Get.find<DioBuilder>(tag: DioBulderType.refresh.name),
      ),
      tag: DioBulderType.withToken.name,
      fenix: true,
    );
    Get.lazyPut(
      () => DioBuilder(
        ignoredToken: true,
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
      ),
      tag: DioBulderType.ignoredToken.name,
      fenix: true,
    );
    Get.lazyPut(
      () => ApiService(Get.find<DioBuilder>(tag: DioBulderType.withToken.name)),
      fenix: true,
    );
  }

  void injectStorageProvider() {
    Get.put(LocalStorage(), permanent: true);
  }

  void injectRepository() {
    Get.put<AuthRepo>(AuthRepoImpl());
    Get.put<ProfileRepo>(ProfileRepoImpl());
    Get.put<HistoryRepo>(HistoryRepoImpl());
    Get.put<BranchRepo>(BranchRepoImpl()); 
  }

  void injectService() {
    Get.put(LogServiceImpl());
    Get.put<AuthService>(AppAuthService());
    Get.put<AuthService>(GoogleAuthService(),
        tag: AuthServiceType.google.name);
    Get.put(PushNotificationService());
  }
}