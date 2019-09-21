import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/custom/ActivityService.dart';

class LeisureActivityTab extends StatefulWidget {
  LeisureActivityTab({Key key, this.title});
  final String title;

  @override
  _LeisureActivityTabState createState() => _LeisureActivityTabState();
}

class _LeisureActivityTabState extends State<LeisureActivityTab> {
  List<Activity> activityList;
  // List<Student> studentsList;
  ActivityService activityService = ActivityService();
  // StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> activitySubscription;
  // StreamSubscription<QuerySnapshot> studentSubscription;

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

    // Student List
    // studentsList = List();
    // studentSubscription?.cancel();
    // studentSubscription = studentService
    //     .getAllPreferredActivities('JfaAiaJ4yAqhqUqey1mG')
    //     .listen((QuerySnapshot snapshot) {
    //   final List<Student> students = snapshot.documents
    //       .map((documentSnapshot) => Student.fromMap(documentSnapshot.data))
    //       .toList();
    //   setState(() {
    //     this.studentsList = students;
    //   });
    // });
  }

  @override
  void dispose() {
    activitySubscription?.cancel();
    // studentSubscription?.cancel();
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
            Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
        onTap: () {
          // studentsList.forEach((n){
          //   print("Hey " + n.toString());
          // });
        },
      );
}
