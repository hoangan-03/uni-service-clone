  import 'package:flutter/material.dart';
import 'package:flutter_base_v2/generated/l10n.dart';

String getTitleForTransactionType(String transactionType, BuildContext context) {
    switch (transactionType) {
      case 'BUY':
        return S.of(context).buy;
      case 'DEPOSIT':
        return S.of(context).deposit_money;
      case 'TRANSFER':
        return S.of(context).transfer_or_get_money;
      default:
        return transactionType;
    }
  }