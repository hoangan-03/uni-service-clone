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
    context: context,
    builder: (BuildContext context) {
      final appColors = Theme.of(context).extension<AppColors>();
      return Container(
        padding: const EdgeInsets.all(16.0),
        color: appColors!.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).select_language,
              style:
                  AppTextStyle.medium14().copyWith(color: appColors.secondary),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text(S.of(context).english),
              trailing: currentLocale.languageCode == 'en'
                  ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                  : null,
              onTap: () {
                localeController.changeLocale(Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(S.of(context).vietnamese),
              trailing: currentLocale.languageCode == 'vi'
                  ? Icon(Icons.check, color: Theme.of(context).primaryColor)
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
