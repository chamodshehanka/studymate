import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestUIScreen extends StatefulWidget {
  _TestUIScreenState createState() => _TestUIScreenState();
}

class _TestUIScreenState extends State<TestUIScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Container(
        child: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text('Admin Activity'),
              onPressed: () => {Navigator.pushNamed(context, '/adminActivity')},
            ),
          ],
        ),
      ),
    );
    // return new StreamBuilder(
    //     stream: Firestore.instance
    //         .collection('activity')
    //         .document('jB1nxpHZEy5TR61H26cs')
    //         .snapshots(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return new Text("Loading");
    //       }
    //       var userDocument = snapshot.data;
    //       return new Text(userDocument["name"]);
    //     });
  }
}
