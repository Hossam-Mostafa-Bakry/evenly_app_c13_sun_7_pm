import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/services/firebase_firestore_serivce.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../models/event_data_model.dart';
import '../home/widgets/event_card_widget.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return SafeArea(
      child: Column(
        children: [
          const CustomTextField(
            hint: "Search For Event",
            hintColor: ColorPalette.generalGreyColor,
            prefixIcon: Icon(
              Icons.search,
              color: ColorPalette.generalGreyColor,
            ),
          ).setHorizontalPadding(context, 0.02),
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
          StreamBuilder<QuerySnapshot<EventDataModel>>(
            stream: FirebaseFirestoreService.getStreamFavoriteData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    const Text(
                      "Something went wrong",
                    ),
                    const SizedBox(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh_outlined,
                        color: ColorPalette.primaryColor,
                      ),
                    )
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorPalette.primaryColor,
                  ),
                );
              }

              List<EventDataModel> eventDataList = snapshot.data!.docs.map(
                (element) {
                  return element.data();
                },
              ).toList();

              return eventDataList.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, index) => EventCardWidget(
                        eventDataModel: eventDataList[index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: eventDataList.length,
                    )
                  : Text(
                      "No Event Created Yet..!",
                      style: theme.textTheme.titleLarge,
                    );
            },
          ),
          // Expanded(
          //   child: ListView.separated(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     itemBuilder: (context, index) => EventCardWidget(
          //       eventDataModel: ,
          //     ),
          //     separatorBuilder: (context, index) => const SizedBox(
          //       height: 10,
          //     ),
          //     itemCount: 4,
          //   ),
          // ),
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
