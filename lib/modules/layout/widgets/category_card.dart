import 'package:evently_app_c13_sun_7_pm/core/extensions/dimensions_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 0.9.width,
      height: 0.25.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/category/meeting.png"),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorPalette.lightCyan,
            ),
            child: const Text(
              "21\nNOV",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorPalette.primaryColor,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorPalette.white,
            ),
            child:  Row(
              children: [
                const Expanded(
                  child: Text(
                    "Meeting for Updating The Development Method ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorPalette.black,
                    ),
                  ),
                ),
                8.spaceHorizontal,
                const Icon(
                  Icons.favorite,
                  color: ColorPalette.primaryColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
