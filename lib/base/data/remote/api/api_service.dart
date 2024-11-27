import 'dart:io';
import 'package:flutter_base_v2/features/account/data/models/response/user.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/getOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/update_info.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/verifyOTP_body.dart';
import 'package:flutter_base_v2/features/deposit/data/models/request/deposit_request.dart';
import 'package:flutter_base_v2/features/deposit/data/models/response/deposit_response.dart';
import 'package:flutter_base_v2/features/transactions/data/models/response/transaction_response.dart';
import 'package:flutter_base_v2/features/qrcode/data/models/response/menu_qr_response.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_detail_reponse.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_request.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_response.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_v2/features/account/data/models/response/user_response.dart';
import 'package:flutter_base_v2/features/authentication/data/models/response/token_response.dart';
import 'package:flutter_base_v2/features/branch/data/models/response/branch_response.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/login_body.dart';
import 'package:flutter_base_v2/features/home/data/models/response/menu_response.dart';
import 'package:flutter_base_v2/features/order/data/models/request/add_payment_request.dart';
import 'package:flutter_base_v2/features/order/data/models/request/add_to_cart_request.dart';
import 'package:flutter_base_v2/features/order/data/models/response/cart_response.dart';
import 'package:flutter_base_v2/features/order/data/models/response/cart_shipping_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

part 'api_service.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class ApiService {
  factory ApiService(Dio dioBuilder) = _ApiService;

  /// REGISTER
  @POST('/auth/guest-register')
  Future<void> getOTP(
    @Body() GetOTPBody body,
  );

  @POST('/auth/verify-otp')
  Future<TokenResponse> verifyOTP(
    @Body() VerifyOTPBody body,
  );

  @POST('/auth/update-info')
  Future<void> updateInfo(
    @Body() UpdateInfoBody body,
  );

  /// USER API
  @POST('/auth/login')
  Future<TokenResponse> loginWithEmail(@Body() LoginBody body);

  @GET('/auth/me')
  Future<UserResponse> getUserProfile();

  @POST('/auth/settings')
  Future<void> updateProfile(
    @Body() UserApiModel body,
  );

  @POST('/auth/update-avatar')
  @MultiPart()
  Future<void> updateAvatar(
      @Part(name: "avatar", contentType: "image/*", fileName: "avatar1.jpeg")
      File avatar);

  /// BRANCH API

  @GET('/branches/options?o=true')
  Future<BranchResponse> getListBrands();

  /// MENU API

  @GET('/menu/qr/{product_id}')
  Future<MenuQRResponse> getQrCode(@Path('product_id') String productId);

  @GET('/menu')
  Future<MenuResponse> getMenuToday(
    @Query('menu') String menu,
    @Query('branchId') String branchId,
  );

  @GET('/auth/logout')
  Future<void> logout();

  /// ORDER API

  @POST('/carts')
  Future<void> addToCart(
    @Body() AddToCartRequest body,
  );
  @GET('/carts')
  Future<CartResponse> getCart(
    @Query('order') String menu,
  );

  @GET('/orders/cart')
  Future<CartShippingResponse> getCartShipping();

  @POST('/orders')
  Future<void> addPayment(
    @Body() AddPaymentRequest body,
  );

  /// HISTORY API
  @GET('/users/user-history')
  Future<TransactionResponse> getUserHistory(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('order') String order,
    @Query('field') String field,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
  );
  @GET('/users/user-history')
  Future<TransactionResponse> getUserHistoryByCategory(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('order') String order,
    @Query('type') String transactionType,
    @Query('field') String field,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
  );

  /// DEPOSIT API
  @POST('/users/deposit')
  Future<DepositResponse> depositRequest(
    @Body() DepositRequest body,
  );

  /// TRANSFER API
  @POST('/transfer')
  Future<TransferResponse> transferRequest(
    @Body() TransferRequest body,
  );

  @GET('/transfer/{txn}')
  Future<TransferDetailResponse> getTransferDetail(
    @Path('txn') String txn,
  );

  @GET('/users/user-phone')
  Future<UserResponse> getUserbyPhone(@Path('phone') String phone);
}
