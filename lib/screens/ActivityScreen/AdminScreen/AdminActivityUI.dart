import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/ActivityService.dart';

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
  String selectedRadio;
  String selectedRadioTile;

  @override
  void initState() {
    super.initState();

    selectedRadio = null;
    selectedRadioTile = null;
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

  setSelectedRadio(String val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(String val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    buildTilesList(Activity leisureActivity) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white30))),
            child: Text(
              leisureActivity.type,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            leisureActivity.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.mode_edit, color: Colors.white, size: 30.0),
          onTap: () => {},
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
                          return 'Please enter some text';
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
                          return 'Please enter some text';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RadioListTile(
                        value: 1,
                        groupValue: selectedRadioTile,
                        title: Text('Social'),
                        onChanged: (val) {
                          setSelectedRadioTile(val);
                        },
                        activeColor: Colors.purple,
                        selected: true,
                      )),
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
                          activityService.createActivity(
                              nameController.text, typeController.text);
                          this.dispose();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  // void _editActivity(BuildContext context, Activity activity){

  // }
}