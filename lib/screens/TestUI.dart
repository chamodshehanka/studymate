import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestUIScreen extends StatefulWidget {
  _TestUIScreenState createState() => _TestUIScreenState();
}

class _TestUIScreenState extends State<TestUIScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing UIs',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Uis'),
        ),
        body: Center(
          child: Container(),
        ),
      ),
    );
  }
}