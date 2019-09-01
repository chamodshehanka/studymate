import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/MedicalRecord.dart';
import 'package:studymate/services/SuperService.dart';

final CollectionReference medicalRecordCollection =
    Firestore.instance.collection('medicalRecord');

class MedicalRecordService extends SuperService<MedicalRecord, String> {
  Stream<QuerySnapshot> getMedicalRecordList({int offset, int limit}) {
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
  Future<MedicalRecord> create(MedicalRecord t) {
    return null;
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
  MedicalRecord getByID(String id) {
    return null;
  }

  @override
  Future remove(String id) {
    return null;
  }

  @override
  Future update(MedicalRecord t) {
    return null;
  }
}
