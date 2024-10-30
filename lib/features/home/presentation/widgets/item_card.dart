import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/domain/entities/product.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

Widget buildItemCard(Product item, BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: NetworkImage(item.imageURL),
                fit: BoxFit.cover,
                
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: AppTextStyle.bold16(),
              ),
              const SizedBox(height: 4),
              Text(
                item.description,
                style: AppTextStyle.regular14(),
              ),
            ],
          ),
        ],
      ),
    );
  }