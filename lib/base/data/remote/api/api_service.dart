import 'dart:io';
import 'package:flutter_base_v2/features/order/data/models/menu_qr_response.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_v2/features/account/data/models/user_response.dart';
import 'package:flutter_base_v2/features/authentication/data/models/token_response.dart';
import 'package:flutter_base_v2/features/branch/data/models/branch_response.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/login_body.dart';
import 'package:flutter_base_v2/features/home/data/models/menu_response.dart';
import 'package:flutter_base_v2/features/order/data/models/add_payment.dart';
import 'package:flutter_base_v2/features/order/data/models/add_to_cart_request.dart';
import 'package:flutter_base_v2/features/order/data/models/cart_response.dart';
import 'package:flutter_base_v2/features/order/data/models/cart_shipping_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

part 'api_service.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class ApiService {
  factory ApiService(Dio dioBuilder) = _ApiService;

  @POST('/auth/login')
  Future<TokenResponse> loginWithEmail(@Body() LoginBody body);

  @GET('/auth/me')
  Future<UserResponse> getUserProfile();

  @POST('/auth/settings')
  Future<void> updateProfile(
    @Body() UserApiModel body,
  );

  // @POST('/auth/update-avatar')
  // @MultiPart()
  // Future<void> updateAvatar(@Part(name: "avatar") List<int> avatar);

  @POST('/auth/update-avatar')
  @MultiPart()
  Future<void> updateAvatar(
      @Part(name: "avatar", contentType: "image/*", fileName: "avatar1.jpeg")
      File avatar);

  @GET('/branches/options?o=true')
  Future<BranchResponse> getListBrands();

  @GET('/menu/qr/{product_id}')
  Future<MenuQRResponse> getQrCode(@Path('product_id') String productId);

  @GET('/menu')
  Future<MenuResponse> getMenuToday(
    @Query('menu') String menu,
    @Query('branchId') String branchId,
  );

  @GET('/auth/logout')
  Future<void> logout();

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
}
