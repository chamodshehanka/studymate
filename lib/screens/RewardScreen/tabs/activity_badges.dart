import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:studymate/models/Badge.dart';
import 'package:studymate/services/custom/BadgeService.dart';
import 'package:flutter/cupertino.dart';

class ActivityBadge extends StatefulWidget {
  ActivityBadge({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ActivityBadgeState createState() => _ActivityBadgeState();
}

class _ActivityBadgeState extends State<ActivityBadge> {
List<Badge> badgeList;
  BadgeService badgeService = BadgeService();
  StreamSubscription<QuerySnapshot> badgeSubscription;

  @override
  void initState() {
    super.initState();

     badgeList = List();
    badgeSubscription?.cancel();
    badgeSubscription = badgeService
        .getActivityBadgeList()
        .listen((QuerySnapshot snapshot) {
      final List<Badge> badges = snapshot.documents
          .map((documentSnapshot) => Badge.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.badgeList = badges;
      });
    });
  }


  @override
  void dispose() {
    badgeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Badge activityBadge) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(activityBadge),
          ),
        );

    final badgeTabBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount:badgeList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(badgeList[index]);
        }, 
      ),
    );

    return Scaffold(backgroundColor: Colors.white10, body: badgeTabBody);
  }

  buildTilesList(Badge activityBadge) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white30))),
          child: 
          Text(
            activityBadge.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          activityBadge.type,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle:Text(
          activityBadge.milestone,
           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ) ,
        trailing:
            Text(
              activityBadge.description,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            ),
        onTap: () => { },
      );
}

  

  