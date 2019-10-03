import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studymate/services/Authentication.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BaseAuthentication _auth = Authentication();
  Future<FirebaseUser> firebaseUser = FirebaseAuth.instance.currentUser();

  void initState() {
    super.initState();
    log("I am in");
    _auth.getCurrentUser().then((currentUser) {
      log("I am in");
          if (currentUser != null){
            log("I am in");
              firebaseUser.then((user) {
                user.getIdToken().then((result) {
                  bool isAdmin = result.claims['moderator'] ?? false;
                  bool isDoctor = result.claims['doctor'] ?? false;
                  bool isStudent = result.claims['student'] ?? false;

                  log("ADMIN " + isAdmin.toString());
                  log("DOCTOR " + isDoctor.toString());
                  log("STUDENT " + isStudent.toString());

                  if (isAdmin) {
                    Navigator.pushNamed(context, '/homeAdmin');
                  } else if (isDoctor) {
                    Navigator.pushNamed(context, '/homeDoctor');
                  } else if (isStudent) {
                    Navigator.pushNamed(context, '/studentMain');
                  }
                });
              });
            }
          
        }).catchError((e){
          log('ERROR : ' + e.toString());
          Navigator.pushNamed(context, '/welcome');

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
