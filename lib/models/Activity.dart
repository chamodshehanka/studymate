// import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  String title;
  String time;
  Activity(this.title, this.time);

  List getActivities() {
    // CollectionReference activityRef = Firestore.instance.collection('activity');
    // Future<QuerySnapshot> eventQuery = activityRef.getDocuments();

    // return documents;
    return [
      Activity("eventQuery.toString()", "9.45 - 10.00"),
      Activity("Play A Sport", "17.00 - 18.00"),
      Activity("Watching Television", "18.30 - 19.00"),
    ];
  }
}
