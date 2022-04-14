import 'package:cloud_firestore/cloud_firestore.dart';
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

/*  Stream<Iterable<CloudTravel>> detailTravel({required String travelId}){
    final detailTrvl = travel.where(travelIdFieldName, isEqualTo: travelId).snapshots()
        .map((event) => event.docs.map((doc) => CloudTravel.fromSnapshot(doc)));
    return detailTrvl;
  }*/

  Future<CloudTravel> createNewTravel({
    required String ownerUserId,
    required String title,
    required String description,
    required DateTime dateTravel,
  }) async {
    final document = await travel.add({
      ownerUserIdFieldName: ownerUserId,
      titleFieldName: title,
      descriptionFieldName: description,
      dateTravelFieldName: dateTravel,
    });
    final fetchedTravel = await document.get();
    return CloudTravel(
      travelId: fetchedTravel.id,
      ownerUserId: ownerUserId,
      title: '',
      description: '',
      dateTravel: DateTime.now(),
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance();

  factory FirebaseCloudStorage() => _shared;
}
