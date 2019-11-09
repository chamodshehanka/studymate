import 'package:flutter/material.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/tabs/AdvancedLevelTab.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/tabs/Grade6-9Tab.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/tabs/OrdinaryLevelTab.dart';


class SubjectListScreen extends StatefulWidget {
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Subjects'),
            backgroundColor: Colors.deepPurple,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text:'6-9'),
                Tab(text: 'O/L',),
                Tab(text: 'A/L')
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Grade69Tab(),
              OrdinaryLevelTab(),
              AdvancedLevelTab(),
            ],
          ),
        ),
      ),
    );
  }
}