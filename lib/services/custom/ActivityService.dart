import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/utils/CommonConstants.dart';

final CollectionReference activityCollection =
    Firestore.instance.collection(CommonConstants.activityCollectionName);

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

  //Get Only Leisure Activities
  Stream<QuerySnapshot> getLeisureActivityList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        activityCollection.where('type', isEqualTo: 'Leisure').snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  //Get Only Social Activities
  Stream<QuerySnapshot> getSocialActivityList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots =
        activityCollection.where('type', isEqualTo: 'Social').snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  //Get All Activites
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
