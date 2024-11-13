import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/home/domain/usecases/get_menu.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/get_profile_uc.dart';
import 'package:flutter_base_v2/features/order/data/models/add_payment.dart';
import 'package:flutter_base_v2/features/order/data/models/add_to_cart_request.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart.dart';
import 'package:flutter_base_v2/features/order/domain/entities/cart_shipping.dart';
import 'package:flutter_base_v2/features/order/domain/entities/menu_qr.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/add_cart_uc.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/add_payment_uc.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/get_cart_shipping_uc.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/get_cart_uc.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/get_qr_code.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';

class HomeController extends BaseController<HomeInput> {
  GetProfileUseCase get _getProfileUseCase => Get.find<GetProfileUseCase>();
  GetMenuUseCase get _getMenuUseCase => Get.find<GetMenuUseCase>();
  GetCartUseCase get _getCartUseCase => Get.find<GetCartUseCase>();
  GetQrCodeUseCase get _getQrCodeUseCase => Get.find<GetQrCodeUseCase>();

  GetCartShippingUseCase get _getCartShippingUsecase =>
      Get.find<GetCartShippingUseCase>();
  BaseState<List<CartShipping>?> getCartShippingState = BaseState();
  final AddCartUseCase _addCartUseCase = Get.find<AddCartUseCase>();
  final AddPaymentUseCase _addPaymentUseCase = Get.find<AddPaymentUseCase>();
  BaseState<List<Menu>?> getMenuPreorderState = BaseState();
  BaseState<List<Menu>?> getMenuTodayState = BaseState();


  BaseState<List<Menu>?> getMenuFoodcourtState = BaseState();
  BaseState<List<Menu>?> getMenuDrinkState = BaseState();
  BaseState<List<Menu>?> getMenuSpecialityState = BaseState();
  BaseState<List<Menu>?> getMenuNecessityState = BaseState();
  final pushNotiService = Get.find<PushNotificationService>();

  final user = User().obs;
  final cart = Cart().obs;
  final qrmenu = MenuQR().obs;

  final LocalStorage _localStorage = Get.find();
  var currentMenu = ''.obs;
  final currentBranchID = '5bb72354-7c84-4f24-b889-a05cbda5d45d'.obs;
  final currentCategory = 'FOODCOURT'.obs;
  final quantity = 0.obs;
  final itemIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    pushNotiService.listenNotification();
    // getProfile();

    getCartShipping();
    getMenuToday("TODAY", currentBranchID.value);
    getMenuToday("PREORDER", currentBranchID.value);
    getMenuToday("FOODCOURT", currentBranchID.value);
    getMenuToday("DRINK", currentBranchID.value);
    getMenuToday("NECESSITY", currentBranchID.value);
    getMenuToday("SPECIALITY", currentBranchID.value);

    final notificationAppLaunchDetails =
        await pushNotiService.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      N.toNotifications();
    }
  }

  @override
  void onClose() {
    pushNotiService.cancelNotification();
    _getProfileUseCase.dispose();
    _getMenuUseCase.dispose();
    _getCartShippingUsecase.dispose();
    super.onClose();
  }

  void showNotifications() {
    pushNotiService.showLocalNotification(
        title: "Demo notifications", body: 'Demo body', payload: 'payload');
  }

  void updateQuantity(int newQuantity) {
    quantity.value = newQuantity;
  }

  void updateItemIndex(int newIndex) {
    itemIndex.value = newIndex;
  }

  void printFcmToken() async {
    final fcmToken = await pushNotiService.fcmToken;
    L.debug(fcmToken);
  }

  void setAccessToken() {
    _localStorage.saveAccessToken('accessToken123123123');
  }

  void setRefreshToken() {
    _localStorage.saveUserRefreshToken('refreshToken123123123');
  }

  // void clearAllData() {
  //   _localStorage.removeAllData();
  // }

  Future<void> getProfile() {
    return _getProfileUseCase.execute(
        observer: Observer(
          onSuccess: (User? data) {
            L.info(data);
            if (data != null) user.value = data;
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: null);
  }

  Future<void> getMenuToday(String category, String branchId) async {
    return _getMenuUseCase.execute(
        observer: Observer(
          onSubscribe: () {
            _getStateByCategory(category).onLoading();
          },
          onSuccess: (List<Menu>? menus) {
            _getStateByCategory(category).onSuccess(data: menus);
          },
          onError: (AppException e) {
            _getStateByCategory(category).onError(e.message);
            handleError(e);
          },
        ),
        input: GetMenuParams(category: category, branchId: branchId));
  }

  Future<String?> getCart() async {
    final completer = Completer<String?>();
    await _getCartUseCase.execute(
        observer: Observer(
          onSuccess: (Cart? data) {
            L.info(data);
            if (data != null) {
              cart.value = data;
              completer.complete(cart.value.id);
            } else {
              completer.complete(null);
            }
          },
          onError: (AppException e) {
            handleError(e);
            completer.completeError(e);
          },
        ),
        input: GetCartParams(order: "NORMAL"));
    return completer.future;
  }

  Future<void> getQrCode(String productId) async {
    return _getQrCodeUseCase.execute(
      observer: Observer(
        onSuccess: (MenuQR? qrMenu) {
          L.info(qrMenu);
          if (qrMenu != null) qrmenu.value = qrMenu;
        },
        onError: (AppException e) {
          handleError(e);
        },
      ),
      input: GetQrCodeParams(productId: productId),
    );
  }

  Future<void> getCartShipping() {
    return _getCartShippingUsecase.execute(
      observer: Observer(
        onSubscribe: () {
          getCartShippingState.onLoading();
        },
        onSuccess: (List<CartShipping>? cartship) {
          getCartShippingState.onSuccess(data: cartship);
        },
        onError: (AppException e) {
          getCartShippingState.onError(e.message);
          handleError(e);
        },
      ),
      input: null,
    );
  }

  Future<void> addToCart(String idProduct, int quantity) async {
    final params = AddToCartRequest(
      idProduct: idProduct,
      quantity: quantity,
    );
    try {
      await _addCartUseCase.build(params);
      await getCart();
      final cartId = cart.value.id;
      if (cartId != null) {
        await addPaymentRequest(cartId);
      }
    } catch (e) {
      print("Failed to add product to cart: $e");
    }
  }

  Future<void> addPaymentRequest(String cartId) async {
    final params = AddPaymentRequest(
      cartId: cartId,
    );
    try {
      await _addPaymentUseCase.build(params);
      print("Paid successfully.");
    } catch (e) {
      print("Failed to pay: $e");
    }
  }

  BaseState<List<Menu>?> _getStateByCategory(String category) {
    switch (category) {
      case 'TODAY':
        return getMenuTodayState;
      case 'PREORDER':
        return getMenuPreorderState;
      case 'FOODCOURT':
        return getMenuFoodcourtState;
      case 'DRINK':
        return getMenuDrinkState;
      case 'SPECIALITY':
        return getMenuSpecialityState;
      case 'NECESSITY':
        return getMenuNecessityState;
      default:
        throw ArgumentError('Invalid category: $category');
    }
  }

  void selectMenu(String menu) {
    currentMenu.value = menu;
  }

  void updateCurrentBranchID(String branchID) {
    currentBranchID.value = branchID;
  }

  void updateCurrentCategory(String category) {
    const validCategories = [
      'TODAY',
      'FOODCOURT',
      'PREORDER',
      'DRINK',
      'SPECIALITY',
      'NECESSITY'
    ];
    if (validCategories.contains(category)) {
      currentCategory.value = category;
    } else {
      throw ArgumentError('Invalid category: $category');
    }
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
