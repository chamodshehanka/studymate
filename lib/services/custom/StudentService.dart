import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:studymate/models/Student.dart';

final CollectionReference studentCollection =
    Firestore.instance.collection('Students');

class StudentService {


  Future<Student> createStudent(String fullName, String email, String password, String schoolName, String phoneNumber) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(studentCollection.document());

      final Student student = new Student(ds.documentID,fullName, email,password, schoolName, phoneNumber);
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

 
  
  Stream<QuerySnapshot> getstudentList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = studentCollection.snapshots();

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
          await tx.get(studentCollection.document(student.id));

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

  Future<dynamic> deletestudent(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(studentCollection.document(id));

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
