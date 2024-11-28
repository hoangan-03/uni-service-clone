  import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

Widget buildBillTimestamp(String currentTime) {
    return Center(
      child: Text(
        currentTime,
        style: AppTextStyle.regular12().copyWith(color: Colors.grey),
      ),
    );
  }