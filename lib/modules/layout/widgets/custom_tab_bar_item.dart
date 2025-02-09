import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

class CustomTabBarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const CustomTabBarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? ColorPalette.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorPalette.white,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? ColorPalette.primaryColor : ColorPalette.white,
          ),
          4.spaceHorizontal,
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:
                  isSelected ? ColorPalette.primaryColor : ColorPalette.white,
            ),
          ),
        ],
      ),
    );
  }
}
