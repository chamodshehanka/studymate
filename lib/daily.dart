import 'package:flutter/material.dart';
import 'package:studymate/dailyleisure.dart';
import 'package:studymate/dailysocial.dart';
import 'package:studymate/dailystudy.dart';

final List<String> entries = <String>[
  '8.30 - 10.30',
  '11.00 - 12.30',
  '13.00 - 14.30',
  '15.00 - 16.00'
];
final List<String> subjects = <String>[
  'Mathematics',
  'Science',
  'English',
  'Sinhala'
];

class DailyScreen extends StatefulWidget {
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
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
                  Tab(icon: Icon(Icons.library_books)),
                  Tab(icon: Icon(Icons.people)),
                  Tab(icon: Icon(Icons.games)),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                DailyStudy(),
                DailySocial(),
                DailyLeisure(),
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
