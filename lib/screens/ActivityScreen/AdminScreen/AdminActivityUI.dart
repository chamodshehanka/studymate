import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ManageActivityUI.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class AdminActivityListScreen extends StatefulWidget {
  _AdminActivityListScreenState createState() =>
      _AdminActivityListScreenState();
}

class _AdminActivityListScreenState extends State<AdminActivityListScreen> {
  List<Activity> activityList;
  ActivityService activityService = ActivityService();
  StreamSubscription<QuerySnapshot> activitySubscription;
  List<String> activityTypeList;
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

    // Dropdown Items load
    activityTypeList = ['Social', 'Leisure'];
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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Activities List'),
          backgroundColor: Colors.deepPurpleAccent,
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
    String activityType;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    child: StudymateTextField(
                        'Activity Name',
                        nameController,
                        'text',
                        false,
                        Colors.grey,
                        TextInputType.text,
                        Icon(
                          Icons.local_activity,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      
                      hint: Text('Activity Type'),
                      value: activityType,
                      items: ["Leisure", "Social"]
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          activityType = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          child: Text("Save"),
                          onPressed: () {
                            log('Activity Type : ' + activityType);

                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              //Adding to DB
                              Future<Activity> isAdded =
                                  activityService.createActivity(
                                      nameController.text, typeController.text);
                              if (isAdded != null) {
                                Navigator.pop(context);
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
                        // Test Dispose button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
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
                ],
              ),
            ),
          );
        });
  }
}
