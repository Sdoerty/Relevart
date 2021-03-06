import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:relevart/services/cloud/cloud_storage_constants.dart';
import 'package:relevart/services/cloud/cloud_travel.dart';

class FirebaseCloudStorage {
  final travel = FirebaseFirestore.instance.collection('travel');

  Stream<Iterable<CloudTravel>> allTravels({required String ownerUserId}) {
    final allTravel = travel
        .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudTravel.fromSnapshot(doc)));
    return allTravel;
  }

  Future<CloudTravel> createNewTravel({
    required String ownerUserId,
    required String title,
    required String description,
    required DateTime dateTravel,
    required bool completed,
    required List<dynamic> travelday,
  }) async {
    final document = await travel.add({
      ownerUserIdFieldName: ownerUserId,
      titleFieldName: title,
      descriptionFieldName: description,
      dateTravelFieldName: dateTravel,
      completedFieldName: completed,
      traveldayFieldName: travelday,
    });
    final fetchedTravel = await document.get();
    return CloudTravel(
      travelId: fetchedTravel.id,
      ownerUserId: ownerUserId,
      title: '',
      description: '',
      dateTravel: DateTime.now(),
      completed: false,
      travelday: [],
    );
  }

/*  Future<void> updateTravel({
    required String travelId,
    required String textDay,
  }) async {
    return travel.doc(travelId).update({traveldayFieldName: textDay});
  }*/

    Future<void> addNewTravelday({
    required String travelId,
    required String textDay,
  }) async {
    return travel.doc(travelId as String).update({traveldayFieldName: FieldValue.arrayUnion([textDay])});
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance();

  factory FirebaseCloudStorage() => _shared;
}
