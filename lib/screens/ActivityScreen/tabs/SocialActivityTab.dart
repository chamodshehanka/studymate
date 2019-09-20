import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/models/ActivityProgress.dart';

import 'package:studymate/services/Authentication.dart';
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
  List<ActivityProgress> activityProgressList;
  ActivityService activityService = ActivityService();
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> socialActivitySubscription;
  BaseAuthentication _auth = Authentication();

  @override
  void initState() {
    super.initState();

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
    activityProgressList = List();
  }

  @override
  void dispose() {
    socialActivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Activity socialActivity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(socialActivity),
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
      trailing: Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
      onTap: () {
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Adding to List'),
          backgroundColor: Colors.deepPurple,
        ));

        // To get current User
        String uid;
        Future<String> currentUser = _auth.getCurrentUser();
        currentUser.then((value) {
          uid = value;
        });

        // Testing purpose
        uid != null ? print('UID : ' + uid) : print('UID is null');

        // Calling Student Service
        getStudentActivities('JfaAiaJ4yAqhqUqey1mG');
      });

  void getStudentActivities(String id) async {
    studentService
        .getAllPreferredActivities(id)
        .listen((QuerySnapshot snapshot) {
      final List<ActivityProgress> activityProgress = snapshot.documents
          .map((documentSnapshot) =>
              ActivityProgress.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        activityProgressList = activityProgress;
        print(activityProgress);
      });
    });
    print(activityProgressList);
  }
}
