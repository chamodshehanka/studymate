import 'package:flutter/material.dart';

class UDSubjectUI extends StatefulWidget {
  UDSubjectUI({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UDSubjectUIState createState() => _UDSubjectUIState();
}

class _UDSubjectUIState extends State<UDSubjectUI> {
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
   
  ];
}

ListTile makeListTile(Subject subject) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Text(
        subject.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
       
      trailing: Icon(Icons.delete,color: Colors.white, size: 30.0),
      title : Icon(Icons.edit, color: Colors.white, size: 30.0),
     
      onTap: () {}, 

    );