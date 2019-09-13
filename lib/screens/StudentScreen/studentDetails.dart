import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/screens/StudentScreen/ManageStudentUI.dart';
import 'package:studymate/services/custom/StudentService.dart';

class StudentDetailsScreen extends StatefulWidget {
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  List<Student> studentList;
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> studentSubscription;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final idController = TextEditingController();


  @override
  void initState() {
    super.initState();

    studentList = List();
    studentSubscription?.cancel();
    studentSubscription =
        studentService.getstudentList().listen((QuerySnapshot snapshot) {
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
    studentSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buildTilesList(Student student) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white30))),
            child: Text(
              student.id,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            student.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.mode_edit, color: Colors.white, size: 30.0),
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ManageStudentScreen(student: student)))
          },
        );

    return MaterialApp(
      title: 'Manage Student UI',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Student Details'),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );}}