import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studymate/screens/UserScreen.dart/AdminAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/AdminListView.dart';

class AdminManagerScreen extends StatefulWidget {
  _AdminManagerScreenState createState() => _AdminManagerScreenState();
}

class _AdminManagerScreenState extends State<AdminManagerScreen> {
  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    log((date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Admin Manager",
            ),
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Add Admin"),
                Tab(text: "View Admins"),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              AdminAddScreen(),
              AdminListView(),
            ],
          ),
        ),
      ),
    );
  }
}
