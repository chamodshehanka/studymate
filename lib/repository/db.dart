import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final db = Firestore.instance;

  Stream<QuerySnapshot> init() {
    return db.collection('').snapshots();
  }

  Future<String> createData(String name) async {
    DocumentReference documentReference = await db.collection('path').add({});
    print(documentReference.documentID);
    return documentReference.documentID;
  }

  Future readData(String id) async {
    DocumentSnapshot snapshot = await db.collection('').document(id).get();
    return snapshot.documentID;
  }
}

DB db = DB();