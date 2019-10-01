import 'package:flutter/material.dart';

class SBadgesScreen extends StatefulWidget {
  @override
  _SBadgesScreenState createState() => _SBadgesScreenState();
}

class   _SBadgesScreenState extends State<SBadgesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          "Badge Collection",
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),

     ), 
     );
  }
  }
