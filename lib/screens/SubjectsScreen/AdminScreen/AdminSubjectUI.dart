import 'dart:async';

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

  @override
  void initState() {
    super.initState();

    subjectList = List();
    subjectSubscription?.cancel();
    subjectSubscription =
        subjectService.getSubjectList().listen((QuerySnapshot snapshot) {
      final List<Subject> activities = snapshot.documents
          .map((documentSnapshot) => Subject.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.subjectList = activities;
      });
    });

    // Dropdown Items load
    subjectTypeList = ['Grade 6-9', 'Ordinary Level','Advanced Level'];
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

    Card makeCard(Subject subject) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(subject),
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
          title: Text('Manage Subjects List'),
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
    showDialog(
        context: context,
        builder: (_) {
          return StudymateDialog();
        });
  }
}

class StudymateDialog extends StatefulWidget {
  _StudymateDialogState createState() => _StudymateDialogState();
}

class _StudymateDialogState extends State<StudymateDialog> {
  final _formKeyAddSubject = GlobalKey<FormState>();
  final nameController = TextEditingController();
  var type;
  SubjectService _subjectService = SubjectService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text('Create Subject',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.deepPurple)),
      content: Form(
        key: _formKeyAddSubject,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StudymateTextField(
              labelText: 'Subject Name',
              textEditingController: nameController,
              validation: 'name',
              icon: Icon(Icons.local_library, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(Icons.directions_run, color: Colors.grey),
                    )),
                value: type,
                hint: Text('Subject Type'),
                items: ["Grade 6-9", "Ordinary Level","Advanced Level"]
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => type = value);
                },
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 10,
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  child: Text("Save"),
                  onPressed: () {
                    if (_formKeyAddSubject.currentState.validate()) {
                      // Adding to DB
                      Future<Subject> isAdded = _subjectService
                          .createSubject(nameController.text, type);

                      if (isAdded != null) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
                SizedBox(width: 10),
                RaisedButton(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
