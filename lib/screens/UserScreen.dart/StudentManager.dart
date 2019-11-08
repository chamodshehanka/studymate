import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studymate/screens/UserScreen.dart/StudentAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/StudentListView.dart';

class StudentManagerScreen extends StatefulWidget {
  _StudentManagerScreenState createState() => _StudentManagerScreenState();
  
}



class _StudentManagerScreenState extends State<StudentManagerScreen> {
 
  @override
  void initState() {
    super.initState();
    DateTime date =  DateTime.now();
      log((date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString()));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Student Manager",
            ),
            backgroundColor: Colors.deepPurple,
            centerTitle:true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Add Student"),
                Tab(text: "View Students"),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              StudentAddScreen(),
              StudentListView(),
            ],
          ),
      
         ),
      ),
    );
  }
}
