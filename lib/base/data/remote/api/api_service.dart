import 'package:dio/dio.dart';
import 'package:flutter_base_v2/features/authentication/data/models/token_response.dart';
import 'package:flutter_base_v2/features/authentication/data/models/user_response.dart';
import 'package:flutter_base_v2/features/branch/data/models/branch_response.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/login_body.dart';
import 'package:flutter_base_v2/features/example_list/data/models/history_response.dart';
import 'package:flutter_base_v2/features/home/data/models/menu_response.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
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
  Future<UserResponse> getProfile();

  @GET('/branches/options?o=true')
  Future<BranchResponse> getListBrands();

  @GET('/menu')
  Future<MenuResponse> getMenu(
    @Query('menu') String category,
    @Query('branchId') String branchid,
  );

  @GET("/users/user-history")
  Future<HistoryResponse> getListHistory(@Query("page") int page,
      {@Query("limit") int perPage = PagingConstants.itemsPerPage,
      @Query("order") String order = 'DESC',
      @Query("field") String field = 'createdAt'});

  @GET('/auth/logout')
  Future<void> logout();
}
