import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/ScheduleTask.dart';
import 'package:studymate/utils/CommonConstants.dart';
class ScheduleService{
final CollectionReference studentsCollection =
  Firestore.instance.collection(CommonConstants.studentsCollectionName);
 
  Future<ScheduleTask> addToSchedule(String studentId,
      ScheduleTask scheduleTask, String day) {
    final TransactionHandler createTransaction = (Transaction tx) async {
       DocumentSnapshot ds = 
           await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.scheduleCollection)
              .document("weeklyschedule")
              .collection(day)
              .document());
          
  scheduleTask.setId(ds.documentID);

      final Map<String, dynamic> data = scheduleTask.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return ScheduleTask.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getDailyTaskList(String studentId,String day) {
   
    Stream<QuerySnapshot> snapshots =
        studentsCollection
              .document(studentId)
              .collection(CommonConstants.scheduleCollection)
              .document("weeklyschedule")
              .collection(day).snapshots();

log("Snapshots "+snapshots.isEmpty.toString());
log(studentId.toString());
log(day.toString());
    return snapshots;
  }

}