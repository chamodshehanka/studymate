import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Subject.dart';
<<<<<<< HEAD
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference subjectCollection =
    Firestore.instance.collection(CommonConstants.subjectCollectionName);

class SubjectService {
  // static final SubejectService _SubjectService = SubjectService();
  // factory SubjectService() => _subjectService;

  Future<Subject> createSubject(String name, String type) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(subjectCollection.document());

      final Subject subject = new Subject(ds.documentID, name, type);
      final Map<String, dynamic> data = subject.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Subject.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  //Get Only GRADE89Subjects
  Stream<QuerySnapshot> getGrade89SubjectList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        subjectCollection.where('type', isEqualTo: 'Grade89').snapshots();
=======
import 'package:studymate/services/SuperService.dart';
>>>>>>> 83812c04f34ca25dd55489e87beadcd536657f42

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  //Get Only OLevel Subjects
  Stream<QuerySnapshot> getOLevelSubjectList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        subjectCollection.where('type', isEqualTo: 'OL').snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  //Get All Subjects
  Stream<QuerySnapshot> getSubjectList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = subjectCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateSubject(Subject subject) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(subjectCollection.document(subject.id));

      await tx.update(ds.reference, subject.toMap());
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

  Future<dynamic> deleteSubject(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(subjectCollection.document(id));

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
