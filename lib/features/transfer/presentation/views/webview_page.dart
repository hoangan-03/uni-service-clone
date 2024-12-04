import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/utils/helper/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({required this.url, super.key});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late final WebViewController _webViewController;
  final AccountController accountController = Get.find<AccountController>();

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            L.info('Loading progress: $progress%');
          },
          onPageStarted: (String url) {
            L.info('Page started loading: $url');
          },
          onPageFinished: (String url) {
            L.info('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            L.info('HTTP error:');
          },
          onWebResourceError: (WebResourceError error) {
            L.info('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://stg.uniservice.vn')) {
              accountController.reloadUserInfo();
              N.toAccount();
              buildSnackBar("Nạp tiền thành công", true);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: S.deposit,
        appColors: appColors,
        hasBackButton: true,
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
