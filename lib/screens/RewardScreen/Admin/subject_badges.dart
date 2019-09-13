import 'package:flutter/material.dart';

class SubjectBadge extends StatefulWidget {
  SubjectBadge({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SubjectBadgeState createState() => _SubjectBadgeState();
}

class _SubjectBadgeState extends State<SubjectBadge> {
  

  @override
  void initState() {
   // subjects = getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      
    );
  }

}