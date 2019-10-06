import 'package:flutter/material.dart';
import 'package:studymate/screens/SubjectsScreen/tabs/Grade89SubjectUI.dart';
import 'package:studymate/screens/SubjectsScreen/tabs/OLevelSubjectUI.dart';
import 'package:studymate/screens/SubjectsScreen/tabs/ALevelSubjectUI.dart';

class SubjectsScreen extends StatefulWidget {
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  
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
                Tab(icon: Icon(Icons.book)),
                Tab(icon: Icon(Icons.book)),
                Tab(icon: Icon(Icons.book))
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Grade89SubjectUI(),
              OLevelSubjectUI(),
              ALevelSubjectUI(),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Colors.deepPurple,
          //   child: Icon(Icons.show_chart),
          //   onPressed: () => Navigator.pushNamed(context, '/subjectProgress'),
          // ),
         ),
      ),
    );
  }
}
