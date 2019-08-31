import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/ActivityService.dart';

class LeisureActivityTab extends StatefulWidget {
  LeisureActivityTab({Key key, this.title});
  final String title;

  @override
  _LeisureActivityTabState createState() => _LeisureActivityTabState();
}

class _LeisureActivityTabState extends State<LeisureActivityTab> {
  List<Activity> activityList;
  ActivityService activityService = ActivityService();
  StreamSubscription<QuerySnapshot> activitySubscription;

  // var _leisureActivityStream;

  @override
  void initState() {
    super.initState();

    activityList = List();
    activitySubscription?.cancel();
    activitySubscription =
        activityService.getActivityList().listen((QuerySnapshot snapshot) {
      final List<Activity> activities = snapshot.documents
          .map((documentSnapshot) => Activity.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.activityList = activities;
      });
    });
  }

  @override
  void dispose() {
    activitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Card makeCard(Activity leisureActivity) => Card(
    //       elevation: 8.0,
    //       margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    //       child: Container(
    //         decoration: BoxDecoration(color: Colors.deepPurpleAccent),
    //         child: buildTilesList(leisureActivity),
    //       ),
    //     );

    // final avtivityBody = Container(
    //   child: ListView.builder(
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     itemCount: activityList.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return makeCard(activityList[index]);
    //     },
    //   ),
    // );

    return Scaffold(backgroundColor: Colors.white10, body: Center(
      child: ListView.builder(
        itemCount: activityList.length,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, position) {

        return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${activityList[position].name}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${activityList[position].id}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10.0)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: Text(
                              '${position + 1}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => {},
                              // onPressed: () => _deleteNote(context, items[position], position)
                              ),
                        ],
                      ),
                      onTap: () => {}//_navigateToNote(context, items[position]),
                    ),
                  ],
                );
              }
      ),
    ));
    // body: avtivityBody,

    // body: StreamBuilder(
    //   stream: _leisureActivityStream,
    //   builder: ,
    // builder: (context, snapshot) {
    //   switch (snapshot.connectionState) {
    //     case ConnectionState.waiting:
    //     case ConnectionState.none:
    //       return LinearProgressIndicator();
    //     case ConnectionState.active:
    //       return Text(snapshot.data);
    //     case ConnectionState.done:
    //       return Text(snapshot.data);
    //   }
    // },
    //   ),
    // );
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
        onTap: () => {},
      );
}
