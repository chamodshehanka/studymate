import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Badge.dart';


final CollectionReference badgeCollection =
    Firestore.instance.collection('badges');

class BadgeService {
  // static final ActivityService _activityService = ActivityService();

  // factory ActivityService() => _activityService;

  Future<Badge> createBadge(String name, String type,String milestone,String description) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(badgeCollection.document());

      final Badge badge = new Badge(ds.documentID, name, type,milestone,description);
      final Map<String, dynamic> data = badge.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Badge.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  

  

//   //Get All Activites
//   Stream<QuerySnapshot> getActivityList({int offset, int limit}) {
//     Stream<QuerySnapshot> snapshots = activityCollection.snapshots();

//     if (offset != null) {
//       snapshots = snapshots.skip(offset);
//     }

//     if (limit != null) {
//       snapshots = snapshots.take(limit);
//     }

//     return snapshots;
//   }

//   Future<dynamic> updateActivity(Activity activity) async {
//     final TransactionHandler updateTransaction = (Transaction tx) async {
//       final DocumentSnapshot ds =
//           await tx.get(activityCollection.document(activity.id));

//       await tx.update(ds.reference, activity.toMap());
//       return {'updated': true};
//     };

//     return Firestore.instance
//         .runTransaction(updateTransaction)
//         .then((result) => result['updated'])
//         .catchError((error) {
//       print('error: $error');
//       return false;
//     });
//   }

//   Future<dynamic> deleteActivity(String id) async {
//     final TransactionHandler deleteTransaction = (Transaction tx) async {
//       final DocumentSnapshot ds = await tx.get(activityCollection.document(id));

//       await tx.delete(ds.reference);
//       return {'deleted': true};
//     };

//     return Firestore.instance
//         .runTransaction(deleteTransaction)
//         .then((result) => result['deleted'])
//         .catchError((error) {
//       print('error: $error');
//       return false;
//     });
//   }
  }
