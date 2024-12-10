import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';

void showLanguageSelectionModal(
    BuildContext context, LocaleController localeController) {
  final currentLocale = localeController.currentLocale;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      final appColors = Theme.of(context).extension<AppColors>();
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: appColors!.white,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).select_language,
              textAlign: TextAlign.center,
              style:
                  AppTextStyle.medium14().copyWith(color: appColors.secondary),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text(S.of(context).english),
              trailing: currentLocale.languageCode == 'en'
                  ? Icon(Icons.check, color: appColors.primary)
                  : null,
              onTap: () {
                localeController.changeLocale(Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(S.of(context).vietnamese),
              trailing: currentLocale.languageCode == 'vi'
                  ? Icon(Icons.check, color: appColors.primary)
                  : null,
              onTap: () {
                localeController.changeLocale(Locale('vi'));
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: elevatedButtonStyle(context),
              child: Text(
                S.of(context).cancel,
                style: elevatedButtonTextStyle(context),
              ),
            ),
          ],
        ),
      );
    },
  );
}
