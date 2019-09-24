import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/models/ActivityProgress.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/services/custom/StudentService.dart';

class SocialActivityTab extends StatefulWidget {
  SocialActivityTab({Key key, this.title});
  final String title;

  @override
  _SocialActivityTabState createState() => _SocialActivityTabState();
}

class _SocialActivityTabState extends State<SocialActivityTab> {
  List<Activity> socialActivityList;
  List<ActivityProgress> studentActivitiesList;
  ActivityService activityService = ActivityService();
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> socialActivitySubscription;
  StreamSubscription<QuerySnapshot> studentActivitiesSubscription;
  String studentId;

  @override
  void initState() {
    super.initState();

    studentId = 'JfaAiaJ4yAqhqUqey1mG';

    socialActivityList = List();
    socialActivitySubscription?.cancel();
    socialActivitySubscription = activityService
        .getSocialActivityList()
        .listen((QuerySnapshot snapshot) {
      final List<Activity> activities = snapshot.documents
          .map((documentSnapshot) => Activity.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.socialActivityList = activities;
      });
    });

    // Student Preferred Activities List
    studentActivitiesList = List();
    studentActivitiesSubscription?.cancel();
    studentActivitiesSubscription = studentService
        .getAllPreferredActivities(studentId)
        .listen((QuerySnapshot snapshot) {
      final List<ActivityProgress> activityProgress = snapshot.documents
          .map((documentSnapshot) =>
              ActivityProgress.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        studentActivitiesList = activityProgress;
      });
    });
  }

  @override
  void dispose() {
    socialActivitySubscription?.cancel();
    studentActivitiesSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Activity socialActivity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Slidable(
            child: Container(
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                child: buildTilesList(socialActivity)),
            actionPane: SlidableBehindActionPane(),
            actions: <Widget>[
              IconSlideAction(
                
              )
            ],
          ),
        );

    final avtivityBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: socialActivityList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(socialActivityList[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white10,
      body: avtivityBody,
    );
  }

  buildTilesList(Activity socialActivity) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white30))),
        child: Text(
          socialActivity.type,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        socialActivity.name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing:
          Icon(getTileIcon(socialActivity), color: Colors.white, size: 30.0),
      onTap: () {
        bool isActivityPreferred = isActivityAlreadyPreferred(socialActivity);

        String snackBarMessage = 'Adding to List';
        if (isActivityPreferred) snackBarMessage = 'Removing from prefer';

        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text(snackBarMessage),
          backgroundColor: Colors.deepPurple,
        ));

        // Pass activity
        ActivityProgress activityProgress =
            ActivityProgress(socialActivity.id, socialActivity.name, 0);

        if (!isActivityPreferred) {
          // Activity Adding
          Future<ActivityProgress> isAdded = studentService
              .addTActivityToProgress(studentId, activityProgress);

          // Preferred Activity Adding SnackBar
          if (isAdded != null) {
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Added to preferred List'),
              backgroundColor: Colors.green,
            ));
          } else {
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Adding failed!'),
              backgroundColor: Colors.redAccent,
            ));
          }
        } else {
          // Preferred Activity removing
          Future<dynamic> isDeleted = studentService.deleteActivityProgress(
              studentId, activityProgress.id);

          if (isDeleted != null) {
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Successfully Removed'),
              backgroundColor: Colors.green,
            ));
          } else {
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Adding failed!'),
              backgroundColor: Colors.redAccent,
            ));
          }
        }
      });

  // To chech whether activity is already preferred
  bool isActivityAlreadyPreferred(Activity activity) {
    bool isActivityAlreadyPreferred = false;

    studentActivitiesList.forEach((preferredActivity) {
      if (activity.name == preferredActivity.name)
        isActivityAlreadyPreferred = true;
    });

    return isActivityAlreadyPreferred;
  }

  // Gets Icons to Tiles
  IconData getTileIcon(Activity activity) {
    IconData iconData = Icons.add_circle_outline;
    if (isActivityAlreadyPreferred(activity))
      iconData = Icons.remove_circle_outline;
    return iconData;
  }
}
