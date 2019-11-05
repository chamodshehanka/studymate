import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/PreferredSubject.dart';
import 'package:studymate/models/Subject.dart';
import 'package:studymate/models/SubjectProgress.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/custom/StudentService.dart';
import 'package:studymate/services/custom/SubjectService.dart';

class AdvancedLevelTab extends StatefulWidget {
  AdvancedLevelTab({Key key, this.title});
  final String title;

  @override
  _AdvancedLevelTabState createState() => _AdvancedLevelTabState();
}

class _AdvancedLevelTabState extends State<AdvancedLevelTab> {
  List<Subject> subjectList;
  List<SubjectProgress> studentSubjectsList;
  SubjectService subjectService = SubjectService();
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> subjectSubscription;
  StreamSubscription<QuerySnapshot> studentSubjectsSubscription;
  String studentId;
  BaseAuthentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();

    subjectList = List();
    subjectSubscription?.cancel();
    subjectSubscription = subjectService
        .getAdvancedLevelSubjectList()
        .listen((QuerySnapshot snapshot) {
      final List<Subject> subjects = snapshot.documents
          .map((documentSnapshot) => Subject.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.subjectList = subjects;
      });
    });

    _authentication.getCurrentUser().then((user) {
      studentId = user;

      // Student Preferred Subjects List
      studentSubjectsList = List();
      studentSubjectsSubscription?.cancel();
      studentSubjectsSubscription = studentService
          .getAllPreferredSubjects(studentId, 'Advanced Level')
          .listen((QuerySnapshot snapshot) {
        final List<SubjectProgress> subjectProgress = snapshot.documents
            .map((documentSnapshot) =>
                SubjectProgress.fromMap(documentSnapshot.data))
            .toList();
        setState(() {
          studentSubjectsList = subjectProgress;
        });
      });
    });
  }

  @override
  void dispose() {
    subjectSubscription?.cancel();
    studentSubjectsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Subject subject) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(subject),
          ),
        );

    final subjectTabBody = subjectList != null
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: subjectList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(subjectList[index]);
              },
            ),
          )
        : Container(
            child: Text('Subjects are not available!!'),
          );

    return Scaffold(backgroundColor: Colors.white10, body: subjectTabBody);
  }

  buildTilesList(Subject subject) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white30))),
          child: Text(
            subject.type,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          subject.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing:
            Icon(getTileIcon(subject), color: Colors.white, size: 30.0),
        onTap: () {
          bool isSubjectPreferred =
              isSubjectAlreadyPreferred(subject);

           String flushBarMessage;
          if (isSubjectPreferred){
            flushBarMessage = 'Removing from prefer';
          }
          else{
            flushBarMessage = 'Adding to List';
          }
Flushbar(
          message: flushBarMessage,
          backgroundColor: Colors.deepPurple,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
          duration: Duration(seconds: 3),

        )..show(context);

          // Pass subject
          PreferredSubject preferredSubject =
              PreferredSubject(subject.name, 0);

          if (!isSubjectPreferred) {
            _authentication.getCurrentUser().then((user) {
              studentId = user;
              // Subject Adding
              Future<SubjectProgress> isAdded =
                  studentService.addToPreferredSubjects(
                      studentId, preferredSubject, subject.type);

              // Preferred Subject Adding SnackBar
              if (isAdded != null) {
                 Flushbar(
                message: 'Added to preferred List',
                backgroundColor: Colors.green,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                duration: Duration(seconds: 3),
              )..show(context);
              } else {
                 Flushbar(
                message: 'Adding failed!',
                backgroundColor: Colors.redAccent,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                duration: Duration(seconds: 3),
              )..show(context);
              }
            });
          } else {
            _authentication.getCurrentUser().then((user) {
              studentId = user;

              // Preferred Subject removing
              Future<dynamic> isDeleted =
                  studentService.deleteFromPreferredSubjects(
                      studentId, subject.name, subject.type);
              isDeleted.then((result) {
                if (result) {
                   Flushbar(
                message: 'Successfully Removed',
                backgroundColor: Colors.green,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                duration: Duration(seconds: 3),
              )..show(context);
                } else {
                  Flushbar(
                message: 'Adding Failed!',
                backgroundColor: Colors.redAccent,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                duration: Duration(seconds: 3),
              )..show(context);
                }
              });
            });
          }
        },
      );

  // To chech whether subject is already preferred
  bool isSubjectAlreadyPreferred(Subject subject) {
    bool isSubjectAlreadyPreferred = false;

    studentSubjectsList.forEach((preferredSubject) {
      if (subject.name == preferredSubject.name)
        isSubjectAlreadyPreferred = true;
    });

    return isSubjectAlreadyPreferred;
  }

  // Gets Icons to Tiles
  IconData getTileIcon(Subject subject) {
    IconData iconData = Icons.add_circle_outline;
    if (isSubjectAlreadyPreferred(subject))
      iconData = Icons.remove_circle_outline;
    return iconData;
  }

}
