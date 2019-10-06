
import 'dart:core';

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
    return snapshots;
  }

   Future<dynamic> deleteTask(
      String studentId, String day,String taskId) {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = 
        await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.scheduleCollection)
              .document("weeklyschedule")
              .collection(day)
              .document(taskId));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

    Future<dynamic> updateTask(
      String studentId, ScheduleTask task,String day) {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = 
        await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.scheduleCollection)
              .document("weeklyschedule")
              .collection(day)
              .document(task.id));


      await tx.update(ds.reference, task.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }




  Stream<QuerySnapshot> getDailySocialTaskList(String studentId,String day) {
   
    Stream<QuerySnapshot> snapshots =
        studentsCollection
              .document(studentId)
              .collection(CommonConstants.scheduleCollection)
              .document('weeklyschedule')
              .collection(day).where('type', isEqualTo: 'Social').snapshots();
    return snapshots;
  }

    Stream<QuerySnapshot> getDailyStudyTaskList(String studentId,String day) {
   
    Stream<QuerySnapshot> snapshots =
        studentsCollection
              .document(studentId)
              .collection(CommonConstants.scheduleCollection)
              .document('weeklyschedule')
              .collection(day).where('type', isEqualTo: 'Study').snapshots();
    return snapshots;
  }

    Stream<QuerySnapshot> getDailyLeisureTaskList(String studentId,String day) {
   
    Stream<QuerySnapshot> snapshots =
        studentsCollection
              .document(studentId)
              .collection(CommonConstants.scheduleCollection)
              .document('weeklyschedule')
              .collection(day).where('type', isEqualTo: 'Leisure').snapshots();
    return snapshots;
  }

    Future<ScheduleTask> addTaskProgress(String studentId,
      String activity,String completion,String duration,String remarks,String date,String type) {

    var data = {
          'completed' : completion,
          'remarks' : remarks, 
          'scheduled' : duration,
        };

    final TransactionHandler createTransaction = (Transaction tx) async {
       DocumentSnapshot ds = 
           await tx.get(Firestore.instance
              .collection(CommonConstants.dailylogCollection)
              .document(studentId)
              .collection(date)
              .document(date)
              .collection("tasks")
              .document("tasks")
              .collection(type)
              .document(activity));
          

      

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

  List<ScheduleTask> sortSchedule(List<ScheduleTask> taskList){
      taskList.sort((a,b) => DateTime.parse(a.start).compareTo(DateTime.parse(b.start)));
      return taskList;
  }
}
