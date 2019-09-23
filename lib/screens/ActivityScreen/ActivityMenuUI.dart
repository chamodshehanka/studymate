import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityMenuScreen extends StatefulWidget {
  _ActivityMenuScreenState createState() => _ActivityMenuScreenState();
}

class _ActivityMenuScreenState extends State<ActivityMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final activityMenuBody = Container();

    return MaterialApp(
      home: Scaffold(
        body: activityMenuBody,
      ),
    );
  }
}
