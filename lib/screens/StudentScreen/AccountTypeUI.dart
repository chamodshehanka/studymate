import 'package:flutter/material.dart';
import 'package:studymate/widgets/StudymateFlatButton.dart';

class AccountTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Icon(
              Icons.business,
              color: Colors.deepPurple,
              size: 125.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 15.0, left: 15.0),
            child: Text(
              "Select Your Account Type!",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepPurple,
                decoration: TextDecoration.none,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: StudymateFlatButton(
              title: "I'm Going To A School",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed("/schoolStudentAddDetails");
              },
              splashColor: Colors.black12,
              borderColor: Colors.white,
              borderWidth: 0,
              color: Colors.deepPurple,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: StudymateFlatButton(
              title: "I'm Not Going To A School",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.black54,
              onPressed: () {
                Navigator.of(context).pushNamed("/nonSchoolStudentAddDetails");
              },
              splashColor: Colors.black12,
              borderColor: Colors.black12,
              borderWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
