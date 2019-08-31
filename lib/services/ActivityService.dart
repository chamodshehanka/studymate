import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Activity.dart';

final CollectionReference activityCollection =
    Firestore.instance.collection('activity');

class ActivityService {
  // static final ActivityService _activityService = ActivityService();

  // factory ActivityService() => _activityService;

  Future<Activity> createActivity(String name, String type) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(activityCollection.document());

      final Activity activity = new Activity(ds.documentID, name, type);
      final Map<String, dynamic> data = activity.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Activity.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getActivityList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = activityCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateActivity(Activity activity) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(activityCollection.document(activity.id));

      await tx.update(ds.reference, activity.toMap());
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

  Future<dynamic> deleteActivity(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(activityCollection.document(id));

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