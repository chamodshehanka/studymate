import 'package:flutter/material.dart';
import 'Grade89SubjectUI.dart';
import 'ALevelSubjectUI.dart';
import 'OLevelSubjectUI.dart';



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
              title: Text("StudyMate"),
              backgroundColor: Colors.deepOrange,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.book)),
                  Tab(icon: Icon(Icons.book)),
                  Tab(icon: Icon(Icons.book)),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Grade89Subject(),
                OLevelSubject(),
                ALevelSubject(),
                
                ],
            )),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Icon(icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text, style: TextStyle(fontSize: 16.0)),
                  ),
                ]),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ));
  }
}


final List<String> subjects = <String>[
  'Mathematics',
  'Science',
  'English',
  'Sinhala',
  'History',
  'Religion',
  'Civics',
  'Geography',
  'Art',
  'Music',
  'Drama',
  'Dance',
  'Tamil',
  'Health',
  'P.T.S.',
];
