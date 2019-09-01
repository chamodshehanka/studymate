import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:studymate/models/MedicalRecord.dart';

final CollectionReference medicalRecordCollection =
    Firestore.instance.collection('medicalRecord');

class MedicalRecordService {
  // Future<MedicalRecord> createMedicalRecord(String name, String date, String url){
  //   final Tra
  // }

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
}
