import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/snack_bar_service.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:evently_app_c13_sun_7_pm/models/event_data_model.dart';
import 'package:evently_app_c13_sun_7_pm/modules/createEvent/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../core/theme/color_palette.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../models/event_category.dart';

class CreateNewEventView extends StatefulWidget {
  const CreateNewEventView({super.key});

  @override
  State<CreateNewEventView> createState() => _CreateNewEventViewState();
}

class _CreateNewEventViewState extends State<CreateNewEventView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  int selectedTap = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new event"),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 1.0.width,
                height: 0.26.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    eventCategories[selectedTap].eventCategoryImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DefaultTabController(
                length: 5,
                child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    indicator: const BoxDecoration(),
                    onTap: (value) {
                      setState(() {
                        selectedTap = value;
                      });
                    },
                    tabs: eventCategories.map(
                      (element) {
                        return TabWidget(
                          eventCategory: element,
                          isSelected:
                              selectedTap == eventCategories.indexOf(element),
                        );
                      },
                    ).toList()),
              ),
              const SizedBox(height: 10),
              Text(
                "Title",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _titleController,
                hint: "Event Title",
                hintColor: ColorPalette.generalGreyColor,
                prefixIcon: const Icon(
                  Icons.edit_note_outlined,
                  color: ColorPalette.generalGreyColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Description",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _descriptionController,
                hint: "Event Description",
                hintColor: ColorPalette.generalGreyColor,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 10),
                  Text(
                    "Event Date",
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      selectEventDate(context);
                    },
                    child: Text(
                      selectedDate != null
                          ? DateFormat("dd MMM yyy").format(selectedDate!)
                          : "Choose Date",
                      style: theme.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Location",
                style: theme.textTheme.titleMedium?.copyWith(),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    side: const BorderSide(color: ColorPalette.primaryColor)),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorPalette.primaryColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const Icon(
                        Icons.my_location_outlined,
                        color: ColorPalette.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Choose Event Location",
                      style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.primaryColor),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorPalette.primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (selectedDate != null) {
                        EventDataModel data = EventDataModel(
                          eventTitle: _titleController.text,
                          eventDescription: _descriptionController.text,
                          eventImage:
                              eventCategories[selectedTap].eventCategoryImg,
                          eventDate: selectedDate!,
                          eventCategory:
                              eventCategories[selectedTap].eventCategoryName,
                        );

                        EasyLoading.show();
                        FirebaseFirestoreService.createNewEvent(data).then(
                          (value) {
                            EasyLoading.dismiss();
                            if (value == true) {
                              navigatorKey.currentState!.pop();
                              SnackBarService.showSuccessMessage(
                                  "Event was successfully created");
                            }
                          },
                        );
                      } else {
                        SnackBarService.showErrorMessage(
                            "you must select event date");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      elevation: 0,
                      backgroundColor: ColorPalette.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      side: const BorderSide(color: ColorPalette.primaryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Event",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.white,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
            ],
          ).setHorizontalPadding(context, 0.04),
        ),
      ),
    );
  }

  void selectEventDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
      });
      print(selectedDate);
    }
  }

  void selectEventTime(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime != null) {
      setState(() {
        selectedTime = newTime;
      });
      print(selectedTime);
    }
  }
}
