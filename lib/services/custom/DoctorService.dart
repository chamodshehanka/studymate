import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference doctorCollection =
    Firestore.instance.collection(CommonConstants.doctorCollectionName);

class DoctorService {
  Future<Doctor> create(Doctor doctor, String authId) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(doctorCollection.document(authId));

      final Doctor doctorModel = new Doctor(authId, doctor.firstName,
          doctor.lastName, doctor.regNo, doctor.nic, doctor.workPlace);
      final Map<String, dynamic> data = doctorModel.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Doctor.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future delete(String id) {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(doctorCollection.document(id));

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

  Stream<QuerySnapshot> getAll({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = doctorCollection.snapshots();

    log('Doctor : ' + CommonConstants.doctorCollectionName);

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<DocumentSnapshot> getByID(String uid) {
    return doctorCollection.document(uid).get();
  }

  Future update(Doctor doctor) {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(doctorCollection.document(doctor.id));

      await tx.update(ds.reference, doctor.toMap());
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
}
