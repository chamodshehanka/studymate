import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Subject.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/ManageSubjectUI.dart';
import 'package:studymate/services/custom/SubjectService.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class AdminSubjectListScreen extends StatefulWidget {
  _AdminSubjectListScreenState createState() =>
      _AdminSubjectListScreenState();
}

class _AdminSubjectListScreenState extends State<AdminSubjectListScreen> {
  List<Subject> subjectList;
  SubjectService subjectService = SubjectService();
  StreamSubscription<QuerySnapshot> subjectSubscription;
  List<String> subjectTypeList;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    subjectList = List();
    subjectSubscription?.cancel();
    subjectSubscription =
        subjectService.getSubjectList().listen((QuerySnapshot snapshot) {
      final List<Subject> subjects = snapshot.documents
          .map((documentSnapshot) => Subject.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.subjectList = subjects;
      });
    });

    // Dropdown Items load
    subjectTypeList = ['Grade89', 'OL', 'AL'];
  }

  @override
  void dispose() {
    subjectSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buildTilesList(Subject subject) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white30))),
            child: Text(
              subject.type,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            subject.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.mode_edit, color: Colors.white, size: 30.0),
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ManageSubjectScreen(subject: subject)))
          },
        );

    Card makeCard(Subject grade89SubjectUI) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(grade89SubjectUI),
          ),
        );

    final adminSubjectBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: subjectList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(subjectList[index]);
        },
      ),
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Subject List'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: adminSubjectBody,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
          onPressed: () => _createNewSubject(context),
        ),
      ),
    );
  }

  void _createNewSubject(BuildContext context) async {
    String subjectType;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              'Create A New Subject',
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
                        'Subject Name',
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
                      
                      hint: Text('Subject Type'),
                      value: subjectType,
                      items: ["Grade89", "OL", "AL"]
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          subjectType = value;
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
                            log('Subject Type : ' + subjectType);

                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              //Adding to DB
                              Future<Subject> isAdded =
                                  subjectService.createSubject(
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
