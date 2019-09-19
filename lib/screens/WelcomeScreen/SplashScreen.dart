import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studymate/services/Authentication.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BaseAuthentication _auth = Authentication();
  void initState() {
    super.initState();
    _auth.getCurrentUser().then((currentUser) => {
      Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, '/welcome')),
      // if(currentUser != null){
      //   // Have to impl correct role based one
      //   Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, '/home'))
      // }else {
      //   Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, '/welcome'))
      // }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              radius: 65.0,
              child: Icon(
                Icons.school,
                color: Colors.white70,
                size: 70.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text(
              'Studymate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 70.0),
            ),
            CircularProgressIndicator(),
          ],
        )
      ],
    ));
  }
}
