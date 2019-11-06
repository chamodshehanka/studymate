import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Badge.dart';
import 'package:studymate/services/custom/BadgeService.dart';

class AdminBadgeListScreen extends StatefulWidget {
  _AdminBadgeListScreenState createState() => _AdminBadgeListScreenState();
}

class _AdminBadgeListScreenState extends State<AdminBadgeListScreen> {
  List<Badge> badgeList;
  BadgeService badgeService = BadgeService();
  StreamSubscription<QuerySnapshot> badgeSubscription;
  List<String> badgeTypeList;

  @override
  void initState() {
    super.initState();

    badgeList = List();
    badgeSubscription?.cancel();
    badgeSubscription =
        badgeService.getBadgeList().listen((QuerySnapshot snapshot) {
      final List<Badge> badges = snapshot.documents
          .map((documentSnapshot) => Badge.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.badgeList = badges;
      });
    });

    // Dropdown Items load
    badgeTypeList = ['Study', 'Social', 'Leisure'];
  }

  @override
  void dispose() {
    badgeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buildTilesList(Badge badge) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white30))),
            child: Text(
              badge.type,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            badge.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.mode_edit, color: Colors.white, size: 30.0),
          onTap: () => {},
        );

    Card makeCard(Badge badge) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(badge),
          ),
        );

    final adminBadgeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: badgeList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(badgeList[index]);
        },
      ),
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Badges List'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: adminBadgeBody,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, '/adminCreateBadge'),
        ),
      ),
    );
  }
}
