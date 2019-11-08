import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/ActivityProgress.dart';
import 'package:studymate/models/PreferredActivity.dart';
import 'package:studymate/models/PreferredSubject.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/models/SubjectProgress.dart';
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference studentsCollection =
    Firestore.instance.collection(CommonConstants.studentsCollectionName);

class StudentService {
  Future<Student> createStudent(Student student, String authId) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(studentsCollection.document(authId));

      final Student studentModel = new Student(
          authId,
          student.firstName,
          student.lastName,
          student.email,
          student.schooling,
          student.schoolName,
          student.phoneNumber,
          student.birthday,
          student.type);
      final Map<String, dynamic> data = studentModel.toMap();

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

  Future<DocumentSnapshot> getByID(String uid) {
    return studentsCollection.document(uid).get();
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

  // Have to change
  Future<ActivityProgress> addToPreferredActivities(String studentId,
      PreferredActivity preferredActivity, String activityType) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = activityType == 'Social'
          ? await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredActivitiesCollectionName)
              .document(activityType)
              .collection(CommonConstants.socialActivitiesCollectionName)
              .document(preferredActivity.name))
          : await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredActivitiesCollectionName)
              .document(activityType)
              .collection(CommonConstants.leisureActivitiesCollectionName)
              .document(preferredActivity.name));

      final PreferredActivity prefer = new PreferredActivity(
          preferredActivity.name, preferredActivity.totalHours);

      final Map<String, dynamic> data = prefer.toMap();

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

  // Have to delete
  Future<dynamic> deleteFromPreferredActivities(
      String studentId, String activityName, String activityType) {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = activityType == 'Social'
          ? await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredActivitiesCollectionName)
              .document(activityType)
              .collection(CommonConstants.socialActivitiesCollectionName)
              .document(activityName))
          : await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredActivitiesCollectionName)
              .document(activityType)
              .collection(CommonConstants.leisureActivitiesCollectionName)
              .document(activityName));

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

  Stream<QuerySnapshot> getAllPreferredActivities(
      String uid, String activityType,
      {int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = activityType == 'Social'
        ? studentsCollection
            .document(uid)
            .collection(CommonConstants.preferredActivitiesCollectionName)
            .document(activityType)
            .collection(CommonConstants.socialActivitiesCollectionName)
            .snapshots()
        : studentsCollection
            .document(uid)
            .collection(CommonConstants.preferredActivitiesCollectionName)
            .document(activityType)
            .collection(CommonConstants.leisureActivitiesCollectionName)
            .snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

    Stream<QuerySnapshot> getAllPreferredSubjects(
      String uid, String syllabus,
      {int offset, int limit}) {
    Stream<QuerySnapshot> snapshots;
        if(syllabus=='Grade 6-9'){
           snapshots = 
           studentsCollection
            .document(uid)
            .collection(CommonConstants.preferredSubjectsCollectionName)
            .document(syllabus)
            .collection(CommonConstants.grade69SubjectsCollectionName)
            .snapshots();
        }
        else if(syllabus=='Ordinary Level'){
           snapshots = 
           studentsCollection
            .document(uid)
            .collection(CommonConstants.preferredSubjectsCollectionName)
            .document(syllabus)
            .collection(CommonConstants.olSubjectsCollectionName)
            .snapshots();
        }
        else if(syllabus=='Advanced Level'){
           snapshots = 
           studentsCollection
            .document(uid)
            .collection(CommonConstants.preferredSubjectsCollectionName)
            .document(syllabus)
            .collection(CommonConstants.alSubjectsCollectionName)
            .snapshots();
        }
   

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  // Have to change
  Future<SubjectProgress> addToPreferredSubjects(String studentId,
      PreferredSubject preferredSubject, String syllabus) {
    final TransactionHandler createTransaction = (Transaction tx) async {
 DocumentSnapshot ds;
if(syllabus=='Grade 6-9'){
           ds = 
          await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredSubjectsCollectionName)
              .document(syllabus)
              .collection(CommonConstants.grade69SubjectsCollectionName)
              .document(preferredSubject.name));
        }
        else if(syllabus=='Ordinary Level'){
            ds =
          await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredSubjectsCollectionName)
              .document(syllabus)
              .collection(CommonConstants.olSubjectsCollectionName)
              .document(preferredSubject.name));
        }
        else if(syllabus=='Advanced Level'){
            ds =
          await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredSubjectsCollectionName)
              .document(syllabus)
              .collection(CommonConstants.alSubjectsCollectionName)
              .document(preferredSubject.name));
        }

      final PreferredActivity prefer = new PreferredActivity(
          preferredSubject.name, preferredSubject.totalHours);

      final Map<String, dynamic> data = prefer.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return SubjectProgress.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  // Have to delete
  Future<dynamic> deleteFromPreferredSubjects(
      String studentId, String subjectName, String syllabus) {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
DocumentSnapshot ds ;

if(syllabus=='Grade 6-9'){
           ds = 
          await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredSubjectsCollectionName)
              .document(syllabus)
              .collection(CommonConstants.grade69SubjectsCollectionName)
              .document(subjectName));
        }
        else if(syllabus=='Ordinary Level'){
            ds =
          await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredSubjectsCollectionName)
              .document(syllabus)
              .collection(CommonConstants.olSubjectsCollectionName)
              .document(subjectName));
        }
        else if(syllabus=='Advanced Level'){
            ds =
          await tx.get(Firestore.instance
              .collection(CommonConstants.studentsCollectionName)
              .document(studentId)
              .collection(CommonConstants.preferredSubjectsCollectionName)
              .document(syllabus)
              .collection(CommonConstants.alSubjectsCollectionName)
              .document(subjectName));
        }

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
