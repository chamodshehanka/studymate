import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:studymate/screens/StudentPlaceHolder.dart';

class StudentMainScreen extends StatefulWidget {

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
      body: FabCircularMenu(
        child: Container(

            child: _children[_currentIndex], 
          ),
          ringColor: Colors.deepPurple,
          ringDiameter: 200.0,
          ringWidth: 60.0,
          options: <Widget>[
            IconButton(icon: Icon(Icons.calendar_today), onPressed: () {}, iconSize: 30.0, color: Colors.white),
            IconButton(icon: Icon(Icons.schedule), onPressed: () {}, iconSize: 30.0, color: Colors.white),
            IconButton(icon: Icon(Icons.chat), onPressed: () {}, iconSize: 30.0, color: Colors.white),
          ],
      ),
      
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.deepPurple,
        buttonBackgroundColor: Colors.deepPurple,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.calendar_today, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
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
