import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminActivityScreen extends StatefulWidget {
  _AdminActivityScreenState createState() => _AdminActivityScreenState();
}

class _AdminActivityScreenState extends State<AdminActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Activities UI',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Activities'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(

        ),
      ),
    );
  }
}
