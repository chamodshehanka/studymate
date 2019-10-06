import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubjectProgressScreen extends StatefulWidget {
  _SubjectProgressScreenState createState() => _SubjectProgressScreenState();
}

class _SubjectProgressScreenState extends State<SubjectProgressScreen> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var subjectProgressBody = Container();

    return MaterialApp(
      title: 'Subject Progress UI',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Subject Progress'),
          backgroundColor: Colors.deepPurple,
        ),
        body: SafeArea(
          child: subjectProgressBody,
        ),
      ),
    );
  }
}
