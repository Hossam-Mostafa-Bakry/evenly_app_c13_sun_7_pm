import 'package:flutter/material.dart';

import '/core/theme/color_palette.dart';
import '../../../../models/event_category.dart';

class HomeTabWidget extends StatelessWidget {
  final EventCategory eventCategory;
  final bool isSelected;

  const HomeTabWidget({
    super.key,
    required this.eventCategory,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: !isSelected ? ColorPalette.primaryColor : ColorPalette.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: ColorPalette.white),
      ),
      child: Row(
        children: [
          Icon(
            eventCategory.eventCategoryIcon,
            color: !isSelected ? ColorPalette.white : ColorPalette.primaryColor,
          ),
          SizedBox(width: 5),
          Text(
            eventCategory.eventCategoryName,
            style: theme.textTheme.titleMedium?.copyWith(
                color: !isSelected
                    ? ColorPalette.white
                    : ColorPalette.primaryColor),
          )
        ],
      ),
    );
  }
}
