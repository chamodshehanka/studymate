import 'package:flutter/material.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 160.0),
            child: Icon(
              Icons.school,
              color: Colors.deepPurpleAccent,
              size: 125.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 15.0, left: 15.0),
            child: Text(
              "Welcome To StudyMate!",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                decoration: TextDecoration.none,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "You will not forget anything with StudyMate",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
              child: StudymateRaisedButton(
                  "Log In",
                  () => {Navigator.pushNamed(context, "/signin")},
                  Colors.deepPurpleAccent)),
        ],
      ),
    );
  }
}
