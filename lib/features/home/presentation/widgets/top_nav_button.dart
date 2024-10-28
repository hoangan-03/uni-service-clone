import 'package:flutter/material.dart';

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
    final bool isSelected = currentMenu == label;

    return GestureDetector(
      onTap: () {
        onMenuSelected(label);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(66, 63, 255, 0.08)
              : Colors.transparent,
          border: Border.all(color: const Color.fromARGB(255, 220, 220, 220)),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: isSelected ? const Color.fromRGBO(66, 63, 255, 1) : Colors.black),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? const Color.fromRGBO(66, 63, 255, 1) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}