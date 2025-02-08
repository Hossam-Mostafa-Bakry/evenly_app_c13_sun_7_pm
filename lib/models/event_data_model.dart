class EventDataModel {
  static const String collectionName = "EventDataCollection";
  String eventID;
  String eventTitle;
  String eventDescription;
  String eventCategory;
  String eventImage;
  DateTime eventDate;
  bool isFavorite;

  EventDataModel({
    this.eventID = "",
    required this.eventTitle,
    required this.eventDescription,
    required this.eventCategory,
    required this.eventImage,
    required this.eventDate,
    this.isFavorite = false,
  });

  /// we need [Function] to convert json to object
  factory EventDataModel.fromFirestore(Map<String, dynamic> json) =>
      EventDataModel(
        eventID: json["eventID"],
        eventTitle: json["eventTitle"],
        eventDescription: json["eventDescription"],
        eventCategory: json["eventCategory"],
        eventImage: json["eventImage"],
        eventDate: DateTime.fromMillisecondsSinceEpoch(json["eventDate"]),
        isFavorite: json["isFavorite"],
      );

  /// we need [Function] to convert object to json
  Map<String, dynamic> toFirestore() {
    return {
      "eventID": eventID,
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventCategory": eventCategory,
      "eventImage": eventImage,
      "eventDate": eventDate.millisecondsSinceEpoch,
      "isFavorite": isFavorite,
    };
  }
}
