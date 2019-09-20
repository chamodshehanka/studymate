import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/models/ActivityProgress.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/services/custom/StudentService.dart';

class LeisureActivityTab extends StatefulWidget {
  LeisureActivityTab({Key key, this.title});
  final String title;

  @override
  _LeisureActivityTabState createState() => _LeisureActivityTabState();
}

class _LeisureActivityTabState extends State<LeisureActivityTab> {
  List<Activity> activityList;
  List<ActivityProgress> studentActivitiesList;
  ActivityService activityService = ActivityService();
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> activitySubscription;
  StreamSubscription<QuerySnapshot> studentActivitiesSubscription;
  String studentId;

  @override
  void initState() {
    super.initState();

    studentId = 'JfaAiaJ4yAqhqUqey1mG';

    activityList = List();
    activitySubscription?.cancel();
    activitySubscription = activityService
        .getLeisureActivityList()
        .listen((QuerySnapshot snapshot) {
      final List<Activity> activities = snapshot.documents
          .map((documentSnapshot) => Activity.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.activityList = activities;
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
    activitySubscription?.cancel();
    studentActivitiesSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Activity leisureActivity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(leisureActivity),
          ),
        );

    final activityTabBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: activityList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(activityList[index]);
        },
      ),
    );

    return Scaffold(backgroundColor: Colors.white10, body: activityTabBody);
  }

  buildTilesList(Activity leisureActivity) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white30))),
          child: Text(
            leisureActivity.type,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          leisureActivity.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing:
            Icon(getTileIcon(leisureActivity), color: Colors.white, size: 30.0),
        onTap: () {
          bool isActivityPreferred =
              isActivityAlreadyPreferred(leisureActivity);

          String snackBarMessage = 'Adding to List';
          if (isActivityPreferred) snackBarMessage = 'Removing from prefer';

          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text(snackBarMessage),
            backgroundColor: Colors.deepPurple,
          ));

          // Pass activity
          ActivityProgress activityProgress =
              ActivityProgress(leisureActivity.id, leisureActivity.name, 0);

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
            isDeleted.then((result) {
              if (result) {
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
            });
          }
        },
      );

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
