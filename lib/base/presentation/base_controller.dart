import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/dispose_bag.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BaseController<T> extends SuperController with FullLifeCycleMixin {
  late Future<OkCancelResult> Function(AppException e) showRetryError;

  late Future<OkCancelResult> Function({
    String? title,
    String? message,
    String? okText,
  }) showOkDialog;

  late Future<OkCancelResult> Function({
    String? title,
    String? message,
    String? okText,
    String? cancelText,
  }) showOkCancelDialog;

  final disposeBag = DisposeBag();

  T get input => Get.arguments;

  @override
  void onClose() {
    disposeBag.dispose();
    super.onClose();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void back() {
    Get.back();
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void initDialog(BuildContext context) {
    showRetryError = (e) {
      if (e.type == AppExceptionType.network) {
        return showOkAlertDialog(
          context: context,
          title: 'S.current.error',
          message: 'S.current.network_error',
          okLabel: 'S.current.try_again',
        );
      }

      return showOkAlertDialog(
        context: context,
        title: 'S.current.error',
        message: 'S.current.common_error_message',
        okLabel: 'S.current.try_again',
      );
    };

    showOkCancelDialog = ({
      String? title,
      String? message,
      String? okText,
      String? cancelText,
    }) {
      return showOkCancelAlertDialog(
        context: context,
        title: title,
        message: message,
        okLabel: okText ?? 'S.current.yes',
        cancelLabel: cancelText ?? 'S.current.no',
      );
    };
    showOkDialog = ({String? title, String? message, String? okText}) {
      return showOkAlertDialog(
        context: context,
        title: title,
        message: message,
        okLabel: okText ?? 'OK',
      );
    };
  }

  void handleError(AppException e, {bool logoutOnUnauthorized = true}) {
    if (e.headerCode == HttpStatus.unauthorized && logoutOnUnauthorized) {
      showOkDialog(title: 'Error', message: 'Your session has been expired, please login.').then((value) {
        Get.find<AuthService>().onUnauthorized();
      });
    } else {
      showOkDialog(title: 'Error', message: e.message);
    }
  }
}
