import 'package:flutter_base_v2/features/account/presentation/controllers/account_binding.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_binding.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_binding.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_binding.dart';
import 'package:get/get.dart';

class TabbarBinding extends Bindings {
  @override
  void dependencies() {
    HomeBinding().dependencies();
    AccountBinding().dependencies();
    BranchBinding().dependencies();
    TransactionBinding().dependencies();
    // QrcodeBinding().dependencies();
  }
}
