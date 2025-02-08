import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/event_data_model.dart';

class FirebaseFirestoreService {
  /// 1- Get Collection Reference
  static CollectionReference<EventDataModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection(EventDataModel.collectionName)
        .withConverter<EventDataModel>(
          fromFirestore: (snapshot, _) =>
              EventDataModel.fromFirestore(snapshot.data()!),
          toFirestore: (eventData, _) => eventData.toFirestore(),
        );
  }

  static Future<bool> createNewEvent(EventDataModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc();
      data.eventID = docRef.id;
      docRef.set(data);
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<List<EventDataModel>> getDataFromFirestore() async {
    var collectionRef = getCollectionReference();
    QuerySnapshot<EventDataModel> data = await collectionRef.get();

    List<EventDataModel> eventDataList = data.docs.map(
      (element) {
        log(element.data().toFirestore().toString());
        return element.data();
      },
    ).toList();
    return eventDataList;
  }

  static Stream<QuerySnapshot<EventDataModel>> getStreamFavoriteData() {
    var collectionRef = getCollectionReference().where(
      "isFavorite",
      isEqualTo: true,
    );

    return collectionRef.snapshots();
  }

  static Stream<QuerySnapshot<EventDataModel>> getStreamData(
      String categoryName) {
    var collectionRef = getCollectionReference().where(
      "eventCategory",
      isEqualTo: categoryName,
    );

    return collectionRef.snapshots();
  }

  Future<bool> deleteEvent(EventDataModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc(data.eventID);

      docRef.delete();

      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<bool> updateEvent(EventDataModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc(data.eventID);

      docRef.update(
        data.toFirestore(),
      );

      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }
}
