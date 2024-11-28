  import 'package:flutter_base_v2/utils/config/app_strings.dart';

String getTitleForTransactionType(String transactionType) {
    switch (transactionType) {
      case 'BUY':
        return S.buy;
      case 'DEPOSIT':
        return S.deposit_money;
      case 'TRANSFER':
        return S.transfer_or_get_money;
      default:
        return transactionType;
    }
  }