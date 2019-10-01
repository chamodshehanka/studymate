import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/MedicalRecord.dart';
import 'package:studymate/services/SuperService.dart';
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference medicalRecordCollection =
    Firestore.instance.collection(CommonConstants.medicalRecordCollection);

class MedicalRecordService extends SuperService<MedicalRecord, String> {
  @override
  Future<MedicalRecord> create(MedicalRecord medicalRecord) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(medicalRecordCollection.document());

      final MedicalRecord md = new MedicalRecord(ds.documentID,
          medicalRecord.name, medicalRecord.date, medicalRecord.url);
      final Map<String, dynamic> data = md.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return MedicalRecord.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  @override
  Stream<QuerySnapshot> getAll({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = medicalRecordCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  @override
  Future delete(String id) {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(medicalRecordCollection.document(id));

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

  @override
  Future update(MedicalRecord medicalRecord) {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(medicalRecordCollection.document(medicalRecord.id));

      await tx.update(ds.reference, medicalRecord.toMap());
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

  @override
  Future<MedicalRecord> getByID(String id) {
    return null;
  }
}
