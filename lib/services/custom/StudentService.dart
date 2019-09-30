import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/ActivityProgress.dart';

import 'package:studymate/models/Student.dart';
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference studentsCollection =
    Firestore.instance.collection(CommonConstants.studentsCollectionName);

class StudentService {
  Future<Student> createStudent(String fullName, String email, String password,
      String schoolName, String phoneNumber) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(studentsCollection.document());

      final Student student = new Student(ds.documentID, fullName, email,
          password, true, schoolName, phoneNumber);
      final Map<String, dynamic> data = student.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Student.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future<Student> getByID(String id) {
    return null;
  }

  Stream<QuerySnapshot> getStudentList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = studentsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateStudent(Student student) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(studentsCollection.document(student.id));

      await tx.update(ds.reference, student.toMap());
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

  Future<dynamic> deleteStudent(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(studentsCollection.document(id));

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

  Future<ActivityProgress> addTActivityToProgress(
      String studentId, ActivityProgress activityProgress) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(Firestore.instance
          .collection(CommonConstants.studentsCollectionName)
          .document(studentId)
          .collection(CommonConstants.activityProgressCollectionName)
          .document());

      final ActivityProgress progress = new ActivityProgress(
          ds.documentID, activityProgress.name, activityProgress.progress);
      final Map<String, dynamic> data = progress.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return ActivityProgress.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getAllPreferredActivities(String id,
      {int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = studentsCollection
        .document(id)
        .collection(CommonConstants.activityProgressCollectionName)
        .snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Future<dynamic> deleteActivityProgress(String studentId, String activityId) {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(Firestore.instance
          .collection(CommonConstants.studentsCollectionName)
          .document(studentId)
          .collection(CommonConstants.activityProgressCollectionName)
          .document(activityId));

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
}
