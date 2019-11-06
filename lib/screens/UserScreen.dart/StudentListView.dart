import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/custom/StudentService.dart';

class StudentListView extends StatefulWidget {
  StudentListView({Key key, this.title});
  final String title;

  @override
  _StudentListViewState createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  List<Student> studentList;
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> studentsSubscription;

  @override
  void initState() {
    super.initState();

    studentList = List();
    studentsSubscription?.cancel();
    studentsSubscription = studentService
        .getStudentList()
        .listen((QuerySnapshot snapshot) {
      final List<Student> students = snapshot.documents
          .map((documentSnapshot) => Student.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.studentList = students;
      });
    });

  }

  @override
  void dispose() {
    studentsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Student student) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Slidable(
            child: Container(
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                child: buildTilesList(student)),
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(caption: 'Delete',
            color: Colors.redAccent,
            icon: Icons.delete,
            onTap: ()=> {},),
            IconSlideAction(caption: 'Update',
            color: Colors.yellowAccent,
            icon: Icons.update,
            onTap: ()=> {},)
            ],
          ),
        );

    final studentBody = studentList != null
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: studentList.length,
              itemBuilder: (BuildContext context, int index) {
                 if(studentList[index].firstName!=null&&studentList[index].lastName!=null)
                  return makeCard(studentList[index]);
                else
                  return null;
              },
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Text(
              'No Any Students!!',
              style: TextStyle(backgroundColor: Colors.red, fontSize: 15),
            ));

    return Scaffold(
      backgroundColor: Colors.white10,
      body: studentBody,
    );
  }

  buildTilesList(Student student) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white30))),
        child: Text(
          student.type,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        student.firstName+" "+student.lastName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing:
          Icon(Icons.view_list),
      onTap: () {
      });

}
