import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/base/data/remote/api/api_service.dart';
import 'package:flutter_base_v2/features/deposit/data/models/deposit_request.dart';
import 'package:flutter_base_v2/features/deposit/data/models/deposit_response.dart';
import 'package:flutter_base_v2/features/deposit/domain/entities/deposit.dart';
import 'package:flutter_base_v2/features/deposit/domain/repositories/deposit_repo.dart';

class DepositRepoImpl extends DepositRepo {
  final ApiService _apiService = Get.find();

  @override
  Future<Deposit> depositRequest(int price) async {
    final request = DepositRequest(
      price: price,
    );
    final DepositResponse response = await _apiService.depositRequest(request);
    final DepositApiModel model = response.data;
    return mappingEntity(model);
  }
}
