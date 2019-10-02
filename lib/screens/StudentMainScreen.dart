import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:studymate/screens/StudentPlaceHolder.dart';

class StudentMainScreen extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _StudentMainScreenState();
  }
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    StudentPlaceholder(0),
   StudentPlaceholder(1),
   StudentPlaceholder(2),
   StudentPlaceholder(3),
  ];
@override
 Widget build(BuildContext context) {
   return Scaffold(
     body: _children[_currentIndex], // new
    bottomNavigationBar: CurvedNavigationBar(
  color: Colors.deepPurple,
  buttonBackgroundColor: Colors.deepPurple,
    backgroundColor: Colors.white,
    items: <Widget>[
      Icon(Icons.home, size: 30,color: Colors.white),
      Icon(Icons.calendar_today, size: 30,color: Colors.white),
      Icon(Icons.favorite, size: 30,color: Colors.white),
      Icon(Icons.person, size: 30,color: Colors.white),
    ],
    onTap: (index) {
     setState(() {
     _currentIndex = index;
   });
    },
  ),
   );
 }
 }
