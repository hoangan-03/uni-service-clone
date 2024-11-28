  import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Icon getIconForTransactionType(String transactionType, AppColors? appColors) {
    switch (transactionType) {
      case 'BUY':
        return Icon(FontAwesomeIcons.burger,
            color: appColors?.primary, size: 24);
      case 'SERVICES':
        return Icon(FontAwesomeIcons.squareParking,
            color: appColors?.onSuccess, size: 24);
      case 'DEPOSIT':
        return Icon(FontAwesomeIcons.wallet, color: Colors.orange, size: 24);
      case 'TRANSFER':
        return Icon(FontAwesomeIcons.moneyBillWave,
            color: Colors.blue, size: 24);
      case 'VENDING_MACHINE':
        return Icon(FontAwesomeIcons.store, color: Colors.purple, size: 24);
      default:
        return Icon(FontAwesomeIcons.question, color: Colors.grey, size: 24);
    }
  }