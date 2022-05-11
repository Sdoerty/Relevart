import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:relevart/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudTravel{
  String travelId;
  String ownerUserId;
  String title;
  String description;
  DateTime dateTravel;
  bool completed;
  List<dynamic> travelday;

  CloudTravel({
    required this.travelId,
    required this.ownerUserId,
    required this.title,
    required this.description,
    required this.dateTravel,
    required this.completed,
    required this.travelday,
});
  final _dateFormat = DateFormat.yMMMd();
  String stringFromDate(DateTime date) => _dateFormat.format(date);

  CloudTravel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot):
        travelId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        title = snapshot.data()[titleFieldName] as String,
        description = snapshot.data()[descriptionFieldName] as String,
        dateTravel = snapshot.data()[dateTravelFieldName].toDate(),
        completed = snapshot.data()[completedFieldName] as bool,
        travelday = snapshot.data()[traveldayFieldName] as List<dynamic>;

}