import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

class TopNavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String currentMenu;
  final Function(String) onMenuSelected;

  const TopNavButton({
    super.key,
    required this.icon,
    required this.label,
    required this.currentMenu,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final bool isSelected = currentMenu == label;

    return GestureDetector(
      onTap: () {
        onMenuSelected(label);
      },
      child: Container(
        constraints: BoxConstraints(minWidth: 65),
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? appColors?.background
              : appColors?.transparent,
          border: Border.all(color: appColors?.lightGray ?? Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: isSelected ? appColors?.primary : appColors?.secondary),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyle.medium12().copyWith(
                color: isSelected ? appColors?.primary : appColors?.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}