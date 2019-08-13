import 'package:flutter/material.dart';

class OtherActivityTab extends StatefulWidget {
  @override
  _OtherActivityTabState createState() => _OtherActivityTabState();
}

class _OtherActivityTabState extends State<OtherActivityTab> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Icon(Icons.directions_bike)
      ],
    );
  }
}