import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference doctorCollection =
    Firestore.instance.collection(CommonConstants.doctorCollectionName);

class DoctorService {
  Future<Doctor> create(Doctor doctor, String authId) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(doctorCollection.document());

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
    return null;
  }

  Stream<QuerySnapshot> getAll({int offset, int limit}) {
    return null;
  }

  Future<Doctor> getByID(String id) {
    return null;
  }

  Future update(Doctor doctor) {
    return null;
  }
}
