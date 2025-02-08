import 'package:evently_app_c13_sun_7_pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_sun_7_pm/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/color_palette.dart';

class EventCardWidget extends StatelessWidget {
  final EventDataModel eventDataModel;

  const EventCardWidget({
    super.key,
    required this.eventDataModel,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 200,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: ColorPalette.primaryColor, width: 1.4),
        image: DecorationImage(
          image: AssetImage(
            eventDataModel.eventImage,
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 2),
            // height: 49,
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              DateFormat("dd MMM").format(eventDataModel.eventDate),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: ColorPalette.primaryColor),
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            // height: 49,
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    eventDataModel.eventTitle,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    eventDataModel.isFavorite = !eventDataModel.isFavorite;
                    FirebaseFirestoreService.updateEvent(eventDataModel);
                  },
                  child: Icon(
                    eventDataModel.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: ColorPalette.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
