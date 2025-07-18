import 'package:flutter_base_v2/features/account/presentation/controllers/account_binding.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account_info.dart';
import 'package:flutter_base_v2/features/account/presentation/views/change_password.dart';
import 'package:flutter_base_v2/features/account/presentation/views/change_pin_number.dart';
import 'package:flutter_base_v2/features/account/presentation/views/set_pin_number.dart';
import 'package:flutter_base_v2/features/account/presentation/views/setting.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/login/login_binding.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_binding.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/register/init_info.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/register/register.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/login/login_page.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/register/verify_otp.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_binding.dart';
import 'package:flutter_base_v2/features/branch/presentation/views/branches_page.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_binding.dart';
import 'package:flutter_base_v2/features/deposit/presentation/views/deposit.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_binding.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_binding.dart';
import 'package:flutter_base_v2/features/home/presentation/views/home_page.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/notifications_page.dart';
import 'package:flutter_base_v2/features/order/presentation/views/bill.dart';
import 'package:flutter_base_v2/features/order/presentation/views/cart_shipping.dart';
import 'package:flutter_base_v2/features/qrcode/presentation/controllers/qrcode_binding.dart';
import 'package:flutter_base_v2/features/services/presentation/views/services.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/controllers/landing/landing_binding.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/controllers/root/root_binding.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/controllers/tabbar/tabbar_binding.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/views/landing/landing_page.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/views/root/root_page.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/views/tabbar/tabbar_page.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_binding.dart';
import 'package:flutter_base_v2/features/transfer/presentation/views/transfer.dart';
import 'package:flutter_base_v2/features/transfer/presentation/views/transfer_bill.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/extension/transition.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account.dart';
import 'package:flutter_base_v2/features/qrcode/presentation/views/qrcode.dart';
import 'package:flutter_base_v2/features/transactions/presentation/views/history.dart';

class AppRoute {
  static String root = '/';
  static String tabbar = '/tabbar';
  static String landing = '/landing';
  static String login = '/login';
  static String register = '/register';
  static String verifyOTP = '/verify_otp';
  static String initInfo = '/init_info';

  static String exampleList = '/example_list';
  static String uniLogin = '/uni_login';
  static String notifications = '/notifications';
  static String home = '/home';
  static String service = '/service';
  static String qr = '/qr';
  static String history = '/history';
  static String account = '/account';
  static String settings = '/settings';
  static String branch = '/branches';
  static String cartShipping = '/cart_shipping';
  static String bill = '/bill';
  static String transferbill = '/transferbill';
  static String accountInfo = '/info';
  static String deposit = '/deposit';
  static String transfer = '/transfer';
  static String setpinnumber = '/set_pin_number';
  static String updatepinnumber = '/update_pin_number';
  static String updatepassword = '/update_password';

  static List<GetPage> generateGetPages = [
    GetPage(
        name: root,
        page: RootPage.new,
        binding: RootBinding(),
        transition: Transition.fade),
    GetPage(
        name: notifications,
        page: NotificationsPage.new,
        transition: Transition.rightToLeft),
    GetPage(
      name: landing,
      page: LandingPage.new,
      binding: LandingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: LoginPage.new,
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: register,
      page: RegisterPage.new,
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: initInfo,
      page: InitInfoPage.new,
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: verifyOTP,
      page: VerifyOtpPage.new,
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: home,
      page: HomePage.new,
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: tabbar,
      page: TabbarPage.new,
      binding: TabbarBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: uniLogin,
      page: LoginPage.new,
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
        name: branch,
        page: BranchsPage.new,
        binding: BranchBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: cartShipping,
        page: CartShippingPage.new,
        binding: HomeBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: accountInfo,
        page: AccountInfoPage.new,
        binding: AccountBinding(),
        customTransition: CustomPageTransition()),
    GetPage(
        name: settings,
        page: SettingPage.new,
        binding: AccountBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: setpinnumber,
        page: SetPinNumberPage.new,
        binding: AccountBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: updatepinnumber,
        page: ChangePinNumberPage.new,
        binding: AccountBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: updatepassword,
        page: ChangePasswordPage.new,
        binding: AccountBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: transferbill,
        page: () => TransferBillPage(
              recipientName: DefaultConstants.defaultRecipientName,
              phone: DefaultConstants.defaultPhone,
              amount: 0,
            ),
        binding: TransferBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: bill,
        page: () => BillPage(
              imageUrl: DefaultConstants.defaultImageUrl,
              branch: DefaultConstants.defaultBranch,
              description: DefaultConstants.defaultDescription,
              name: DefaultConstants.defaultName,
              quantity: 1,
              totalPrice: 0,
              branchName: DefaultConstants.defaultBranchName,
            ),
        binding: HomeBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: service,
        page: ServicesPage.new,
        transition: Transition.rightToLeft),
    GetPage(
        name: qr,
        page: QRPage.new,
        binding: QrcodeBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: history,
        page: HistoryPage.new,
        binding: TransactionBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: deposit,
        page: DepositPage.new,
        binding: DepositBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: transfer,
        page: () =>
            TransferPage(recipientId: DefaultConstants.defaultRecipientId),
        binding: TransferBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: account,
        page: AccountPage.new,
        binding: AccountBinding(),
        transition: Transition.rightToLeft),
  ];

  static GetPage? getPage(String name) {
    return generateGetPages.firstWhereOrNull((e) => e.name == name);
  }
}
