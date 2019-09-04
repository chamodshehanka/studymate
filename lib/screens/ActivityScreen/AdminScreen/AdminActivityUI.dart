import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ManageActivityUI.dart';
import 'package:studymate/services/custom/ActivityService.dart';

class AdminActivityScreen extends StatefulWidget {
  _AdminActivityScreenState createState() => _AdminActivityScreenState();
}

class _AdminActivityScreenState extends State<AdminActivityScreen> {
  List<Activity> activityList;
  ActivityService activityService = ActivityService();
  StreamSubscription<QuerySnapshot> activitySubscription;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();

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
    buildTilesList(Activity activity) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white30))),
            child: Text(
              activity.type,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            activity.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.mode_edit, color: Colors.white, size: 30.0),
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ManageActivityScreen(activity: activity)))
          },
        );

    Card makeCard(Activity leisureActivity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(leisureActivity),
          ),
        );

    final adminActivityBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: activityList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(activityList[index]);
        },
      ),
    );
    return MaterialApp(
      title: 'Manage Activities UI',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Activities'),
          backgroundColor: Colors.deepPurple,
        ),
        body: adminActivityBody,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
          onPressed: () => _createNewActivity(context),
        ),
      ),
    );
  }

  void _createNewActivity(BuildContext context) async {
    // String activityType;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Create A New Activity',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.deepPurple[50],
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Enter activity name'),
                      controller: nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter activity name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Enter activity type'),
                      controller: typeController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter activity type';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: DropdownButton<String>(
                  //       value: 'Activity type',
                  //       onChanged: (String value) {
                  //         setState(() {
                  //           activityType = value;
                  //         });
                  //       },
                  //       items: <DropdownMenuItem<String>>[
                  //         DropdownMenuItem(
                  //           value: 'Social',
                  //           child: Text('Social'),
                  //         ),
                  //         DropdownMenuItem(
                  //           value: 'Leisure',
                  //           child: Text('Leisure'),
                  //         ),
                  //         DropdownMenuItem(
                  //           value: 'Other',
                  //           child: Text('Other'),
                  //         ),
                  //       ],
                  //     )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Text("Save"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          //Adding to DB
                          Future<Activity> isAdded =
                              activityService.createActivity(
                                  nameController.text, typeController.text);
                          if (isAdded != null) {
                            Navigator.pop(context);
                            Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text('Sucessfully Added!'),
                              backgroundColor: Colors.deepPurple,
                            ));
                          } else {
                            //Have to add error message
                            Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text('Failed to Add!'),
                              backgroundColor: Colors.deepPurple,
                            ));
                          }
                        }
                      },
                    ),
                  ),
                  //Test Dispose button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
