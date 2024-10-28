import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
import 'package:flutter_base_v2/features/home/presentation/views/menu/menu.dart';

Widget buildSectionHeader(String title, String actionText, BuildContext context, List<MenuItem> menuItems) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPage(title: title, menuItems: menuItems),
              ),
            );
          },
          child: Row(
            children: [
              Text(
                actionText,
                style: const TextStyle(color: Colors.blue),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }