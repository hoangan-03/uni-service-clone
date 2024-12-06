  import 'package:flutter_base_v2/utils/config/app_strings.dart';

String getTitleForTransactionType(String transactionType) {
    switch (transactionType) {
      case 'BUY':
        return SS.buy;
      case 'DEPOSIT':
        return SS.deposit_money;
      case 'TRANSFER':
        return SS.transfer_or_get_money;
      default:
        return transactionType;
    }
  }