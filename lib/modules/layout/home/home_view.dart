import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_sun_7_pm/models/event_data_model.dart';
import 'package:evently_app_c13_sun_7_pm/modules/layout/home/widgets/event_card_widget.dart';
import 'package:evently_app_c13_sun_7_pm/modules/layout/home/widgets/home_header_widget.dart';
import 'package:evently_app_c13_sun_7_pm/modules/layout/home/widgets/home_tab_widget.dart';
import 'package:evently_app_c13_sun_7_pm/modules/layout/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/color_palette.dart';
import '../../../models/event_category.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedTapIndex = 0;
  List<EventCategory> eventCategories = [
    EventCategory(
      eventCategoryName: "Book Club",
      eventCategoryIcon: Icons.menu_book_outlined,
      eventCategoryImg: "assets/images/book_club_img.png",
    ),
    EventCategory(
        eventCategoryName: "Sport",
        eventCategoryIcon: Icons.directions_bike,
        eventCategoryImg: "assets/images/sport_img.png"),
    EventCategory(
        eventCategoryName: "BirthDay",
        eventCategoryIcon: Icons.cake_outlined,
        eventCategoryImg: "assets/images/birthday_img.png"),
    EventCategory(
        eventCategoryName: "Meeting",
        eventCategoryIcon: Icons.meeting_room_outlined,
        eventCategoryImg: "assets/images/meeting_img.png"),
    EventCategory(
        eventCategoryName: "Holiday",
        eventCategoryIcon: Icons.holiday_village_outlined,
        eventCategoryImg: "assets/images/holiday_img.png"),
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            // height: mediaQuery.size.height * 0.25,
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: ColorPalette.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back ✨",
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: ColorPalette.white),
                        ),
                        Text(
                          "John Safwat",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.white,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/un_selected_map_icn.png",
                              height: 25,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Cairo, Egypt",
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (provider.isDark()) {
                              provider.setCurrentTheme(ThemeMode.light);
                            } else {
                              provider.setCurrentTheme(ThemeMode.dark);
                            }
                          },
                          child: Icon(
                            Icons.wb_sunny_outlined,
                            size: 28,
                            color: ColorPalette.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorPalette.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "EN",
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: ColorPalette.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                DefaultTabController(
                  length: 5,
                  child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      indicator: const BoxDecoration(),
                      onTap: (value) {
                        setState(() {
                          selectedTapIndex = value;
                        });
                      },
                      tabs: eventCategories.map(
                        (element) {
                          return HomeTabWidget(
                            eventCategory: element,
                            isSelected: selectedTapIndex ==
                                eventCategories.indexOf(element),
                          );
                        },
                      ).toList()),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
          StreamBuilder<QuerySnapshot<EventDataModel>>(
            stream: FirebaseFirestoreService.getStreamData(
              eventCategories[selectedTapIndex].eventCategoryName,
            ),
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
          // FutureBuilder<List<EventDataModel>>(
          //   future: FirebaseFirestoreService.getDataFromFirestore(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return Column(
          //         children: [
          //           const Text(
          //             "Something went wrong",
          //           ),
          //           const SizedBox(),
          //           IconButton(
          //             onPressed: () {},
          //             icon: const Icon(
          //               Icons.refresh_outlined,
          //               color: ColorPalette.primaryColor,
          //             ),
          //           )
          //         ],
          //       );
          //     }
          //
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(
          //           color: ColorPalette.primaryColor,
          //         ),
          //       );
          //     }
          //
          //     List<EventDataModel> eventDataList = snapshot.data ?? [];
          //
          //     return eventDataList.isNotEmpty
          //         ? ListView.separated(
          //             shrinkWrap: true,
          //             physics: const NeverScrollableScrollPhysics(),
          //             padding: const EdgeInsets.symmetric(horizontal: 10),
          //             itemBuilder: (context, index) => EventCardWidget(
          //               eventDataModel: eventDataList[index],
          //             ),
          //             separatorBuilder: (context, index) => const SizedBox(
          //               height: 10,
          //             ),
          //             itemCount: eventDataList.length,
          //           )
          //         : Text(
          //             "No Event Created Yet..!",
          //             style: theme.textTheme.titleLarge,
          //           );
          //   },
          // ),
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
