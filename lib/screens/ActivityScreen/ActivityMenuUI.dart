import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/widgets/MultiOptionButton/MultiOptionButton.dart';

class ActivityMenuScreen extends StatefulWidget {
  _ActivityMenuScreenState createState() => _ActivityMenuScreenState();
}

class _ActivityMenuScreenState extends State<ActivityMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[50],
        body: Align(
            alignment: Alignment.bottomRight, child: MultiOptionButton())
            );
  }
}
