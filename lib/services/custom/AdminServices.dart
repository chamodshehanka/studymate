import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Admin.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference adminsCollection =
    Firestore.instance.collection(CommonConstants.adminsCollectionName);
BaseAuthentication authentication = Authentication();

class AdminService {
  Future<Admin> create(Admin admin, String authId) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(adminsCollection.document(authId));

      final Admin adminModel = new Admin(authId, admin.firstName,
          admin.lastName, admin.email, admin.contactNo, admin.workPlace);
      final Map<String, dynamic> data = adminModel.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Admin.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future delete(String id) async{
     final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(adminsCollection.document(id));

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
        Stream<QuerySnapshot> snapshots =
        adminsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<Admin> getByID(String id) {
    return null;
  }

  Future update(Admin admin) {
    return null;
  }
}
