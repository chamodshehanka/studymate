import 'package:flutter/material.dart';

class OtherActivityTab extends StatefulWidget {
  @override
  _OtherActivityTabState createState() => _OtherActivityTabState();
}

class _OtherActivityTabState extends State<OtherActivityTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Text(
          'This feature is coming soon',
          style: TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
