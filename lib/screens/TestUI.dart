import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestUIScreen extends StatefulWidget {
  _TestUIScreenState createState() => _TestUIScreenState();
}

class _TestUIScreenState extends State<TestUIScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text('Admin Activity'),
              color: Colors.deepPurpleAccent,
              textColor: Colors.white,
              focusColor: Colors.deepPurple,
              onPressed: () => {Navigator.pushNamed(context, '/adminActivity')},
            ),
            
          ],
        ),
      ),
    ),);
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
