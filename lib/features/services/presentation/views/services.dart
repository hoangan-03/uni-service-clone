import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ServicesPage extends BaseGetView<HomeController> {
  const ServicesPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: buildAppBar(
          appColors: appColors,
          context: context,
          title: S.of(context).services,
          hasBackButton: false),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: appColors!.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ServiceCard(
                imageUrl: AppImageConstants.vexereurl,
                title: S.of(context).vexere,
              ),
              const SizedBox(height: 12),
              ServiceCard(
                imageUrl: AppImageConstants.btaskeeurl,
                title: S.of(context).btaskee,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  String? token = await FirebaseMessaging.instance.getToken();
                  if (token != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('FCM Token: $token')),
                    );
                  }
                },
                child: Text('Get FCM Token'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ServiceCard({
    required this.imageUrl,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appColors!.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(title,
                      style: AppTextStyle.bold16()
                          .copyWith(color: appColors.secondary)),
                ),
                TextButton(
                  onPressed: () {
                    // Define button action
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: appColors.background,
                    minimumSize: const Size(80, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    S.of(context).book_ticket,
                    style: TextStyle(color: appColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}