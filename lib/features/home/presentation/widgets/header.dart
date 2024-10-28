import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/truncate_text.dart';

Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 50);
                },
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nguyễn Hoàng Ân',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(truncateText("Sample", 30), style: const TextStyle(fontSize: 14, color: Colors.black)),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
