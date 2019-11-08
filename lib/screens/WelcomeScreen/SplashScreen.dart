import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BaseAuthentication _auth = Authentication();
  Future<FirebaseUser> firebaseUser = FirebaseAuth.instance.currentUser();

  // Future<List> _getDailySocialFromSharedPrefs() async{
  //     final prefs = await SharedPreferences.getInstance();
  //     final dailySocial = prefs.get('dailySocial');
  //     return dailySocial;

  // }

  Future<void> _setDailyTimeToSharedPrefs(String studentId) async {
    final prefs = await SharedPreferences.getInstance();
    ScheduleService scheduleService = new ScheduleService();

    int today = DateTime.now().weekday;
    String day;
    switch (today) {
      case 1:
        day = "monday";
        break;
      case 2:
        day = "tuesday";
        break;
      case 3:
        day = "wednesday";
        break;
      case 4:
        day = "thursday";
        break;
      case 5:
        day = "friday";
        break;
      case 6:
        day = "saturday";
        break;
      case 7:
        day = "sunday";
        break;
    }

    await prefs.setInt(
        'dailySocial', scheduleService.getDailySocialTime(day, studentId));
    await prefs.setInt(
        'dailyStudy', scheduleService.getDailyStudyTime(day, studentId));
    await prefs.setInt(
        'dailyLeisure', scheduleService.getDailyLeisureTime(day, studentId));
  }

  void initState() {
    super.initState();
    _auth.getCurrentUser().then((currentUser) {
      if (currentUser != null) {
        firebaseUser.then((user) {
          user.getIdToken().then((result) async {
            bool isAdmin = result.claims['moderator'] ?? false;
            bool isDoctor = result.claims['doctor'] ?? false;
            bool isStudent = result.claims['student'] ?? false;

            if (isAdmin) {
              Navigator.pushNamed(context, '/homeAdmin');
            } else if (isDoctor) {
              Navigator.pushNamed(context, '/homeDoctor');
            } else if (isStudent) {
              final prefs = await SharedPreferences.getInstance();

              if (prefs.get('dailySocial') == null) {
                log("Inside Prefs");
                _setDailyTimeToSharedPrefs(currentUser);
              }
              Navigator.pushNamed(context, '/studentMain');
            }
          });
        });
      }
    }).catchError((e) {
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
