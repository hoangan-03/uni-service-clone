import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/utils/helper/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
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
            print('Loading progress: $progress%');
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            print('HTTP error:');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://stg.uniservice.vn')) {
              accountController.reloadUserInfo();
              N.toAccount();
              buildSnackBar(S.deposit_success, true);
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
