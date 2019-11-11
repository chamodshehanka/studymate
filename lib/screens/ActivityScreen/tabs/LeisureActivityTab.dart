import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/models/ActivityProgress.dart';
import 'package:studymate/models/PreferredActivity.dart';
import 'package:studymate/services/Authentication.dart';
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
  BaseAuthentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();

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

    _authentication.getCurrentUser().then((user) {
      studentId = user;

      // Student Preferred Activities List
      studentActivitiesList = List();
      studentActivitiesSubscription?.cancel();
      studentActivitiesSubscription = studentService
          .getAllPreferredActivities(studentId, 'Leisure')
          .listen((QuerySnapshot snapshot) {
        final List<ActivityProgress> activityProgress = snapshot.documents
            .map((documentSnapshot) =>
                ActivityProgress.fromMap(documentSnapshot.data))
            .toList();
        setState(() {
          studentActivitiesList = activityProgress;
        });
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

    final activityTabBody = activityList != null
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: activityList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(activityList[index]);
              },
            ),
          )
        : Container(
            child: Text('Activities are not available!!'),
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

          String flushBarMessage;
          if (isActivityPreferred) {
            flushBarMessage = 'Removing from prefer';
          } else {
            flushBarMessage = 'Adding to List';
          }

          Flushbar(
            message: flushBarMessage,
            backgroundColor: Colors.deepPurple,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
            duration: Duration(seconds: 3),
          )..show(context);

          // Pass activity
          PreferredActivity preferredActivity =
              PreferredActivity(leisureActivity.name, 0);

          if (!isActivityPreferred) {
            _authentication.getCurrentUser().then((user) {
              studentId = user;
              // Activity Adding
              Future<ActivityProgress> isAdded =
                  studentService.addToPreferredActivities(
                      studentId, preferredActivity, leisureActivity.type);

              // Preferred Activity Adding SnackBar
              if (isAdded != null) {
                Flushbar(
                  message: 'Added to preferred List',
                  backgroundColor: Colors.green,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                  duration: Duration(seconds: 3),
                )..show(context);
              } else {
                Flushbar(
                  message: 'Adding failed!',
                  backgroundColor: Colors.redAccent,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                  duration: Duration(seconds: 3),
                )..show(context);
              }
            });
          } else {
            _authentication.getCurrentUser().then((user) {
              studentId = user;

              // Preferred Activity removing
              Future<dynamic> isDeleted =
                  studentService.deleteFromPreferredActivities(
                      studentId, leisureActivity.name, leisureActivity.type);
              isDeleted.then((result) {
                if (result) {
                  Flushbar(
                    message: 'Successfully Removed',
                    backgroundColor: Colors.green,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                    duration: Duration(seconds: 3),
                  )..show(context);
                } else {
                  Flushbar(
                    message: 'Adding Failed!',
                    backgroundColor: Colors.redAccent,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                    duration: Duration(seconds: 3),
                  )..show(context);
                }
              });
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
