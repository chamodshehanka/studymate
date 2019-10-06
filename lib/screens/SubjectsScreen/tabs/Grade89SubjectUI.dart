import 'package:flutter/material.dart';

class Grade89SubjectUI extends StatefulWidget {
  Grade89SubjectUI({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Grade89SubjectUIState createState() => _Grade89SubjectUIState();
}

class _Grade89SubjectUIState extends State<Grade89SubjectUI> {
  List subjects;

  @override
  void initState() {
    subjects = getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Subject subject) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(subject),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(subjects[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
    );
  }
}

class Subject {
  String title;
  Subject(this.title);
}

List getSubjects() {
  return [
    Subject("Mathematics"),
    Subject("Science"),
    Subject("English"),
    Subject("Sinhala"),
    Subject("History"),
    Subject("Religion"),
    Subject("Civics"),
    Subject("Geography"),
    Subject("Art"),
    Subject("Music"),
    Subject("Drama"),
    Subject("Dance"),
    Subject("Tamil"),
    Subject("Health"),
    Subject("P.T.S."),
  ];
}

ListTile makeListTile(Subject subject) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        subject.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
      onTap: () {},
    );
