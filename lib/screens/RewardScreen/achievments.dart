import 'package:flutter/material.dart';

class AchievmentsScreen extends StatefulWidget {
  @override
  _AchievmentsScreenState createState() => _AchievmentsScreenState();
}

class   _AchievmentsScreenState extends State<AchievmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          "Achievements",
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),

      ),
     );
      }
}
