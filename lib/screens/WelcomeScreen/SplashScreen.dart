import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymate/models/Admin.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/custom/AdminServices.dart';
import 'package:studymate/services/custom/DoctorService.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';
import 'package:studymate/services/custom/SharedPreferences.dart';
import 'package:studymate/services/custom/StudentService.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BaseAuthentication _auth = Authentication();
  Future<FirebaseUser> firebaseUser = FirebaseAuth.instance.currentUser();

  SharedPreferences prefs;
  int social;

  Future<SharedPreferences> getSPInstance() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  Future<void> _setDailyTimeToSharedPrefs(String studentId) async {
    ScheduleService scheduleService = new ScheduleService();
    bool available;
    int today = DateTime.now().weekday;
    String day;
    switch (today) {
      case 1:
        {
          day = "monday";
          if (!prefs.containsKey('socialMon')) addScheduleTimeMonday(0, 0, 0);
          if (prefs.getInt('socialMon') == 0) {
            available = false;
          }
        }
        break;
      case 2:
        {
          if (!prefs.containsKey('socialTue')) addScheduleTimeTuesday(0, 0, 0);
          day = "tuesday";
          if (prefs.getInt('socialTue') == 0) {
            available = false;
          }
        }
        break;
      case 3:
        {
          if (!prefs.containsKey('socialWed'))
            addScheduleTimeWednesday(0, 0, 0);
          day = "wednesday";
          if (prefs.getInt('socialWed') == 0) {
            available = false;
          }
        }
        break;
      case 4:
        {
          if (!prefs.containsKey('socialThu')) addScheduleTimeThursday(0, 0, 0);
          day = "thursday";
          if (prefs.getInt('socialThu') == 0) {
            available = false;
          }
        }
        break;
      case 5:
        {
          if (!prefs.containsKey('socialFri')) addScheduleTimeFriday(0, 0, 0);
          day = "friday";
          if (prefs.getInt('socialFri') == 0) {
            available = false;
          }
        }
        break;
      case 6:
        {
          if (!prefs.containsKey('socialSat')) addScheduleTimeSaturday(0, 0, 0);
          day = "saturday";
          if (prefs.getInt('socialSat') == 0) {
            available = false;
          }
        }
        break;
      case 7:
        {
          if (!prefs.containsKey('socialSun')) addScheduleTimeSunday(0, 0, 0);
          day = "sunday";
          if (prefs.getInt('socialSun') == 0) {
            available = false;
          }
        }
        break;
    }
    if (!available) {
      int leisure = scheduleService.getDailyLeisureTime(day, studentId);
      int study = scheduleService.getDailyStudyTime(day, studentId);

      switch (day) {
        case 'monday':
          addScheduleTimeMonday(social, leisure, study);
          break;
        case 'tuesday':
          addScheduleTimeTuesday(social, leisure, study);
          break;
        case 'wednesday':
          addScheduleTimeWednesday(social, leisure, study);
          break;
        case 'thursday':
          addScheduleTimeThursday(social, leisure, study);
          break;
        case 'friday':
          addScheduleTimeFriday(social, leisure, study);
          break;
        case 'saturday':
          addScheduleTimeSaturday(social, leisure, study);
          break;
        case 'sunday':
          addScheduleTimeSunday(social, leisure, study);
          break;
      }
    }
  }

  void initState() {
    super.initState();

    getSPInstance().then((instance) {
      setState(() {
        prefs = instance;
      });
    });
    _auth.getCurrentUser().then((currentUser) {
      if (currentUser != null) {
        firebaseUser.then((user) {
          user.getIdToken().then((result) async {
            bool isAdmin = result.claims['moderator'] ?? false;
            bool isDoctor = result.claims['doctor'] ?? false;
            bool isStudent = result.claims['student'] ?? false;

            if (isAdmin) {
              if (!prefs.containsKey('currentUserA')) {
                AdminService().getByID(user.uid).then((cUser) {
                  Admin admin = Admin.fromMap(cUser.data);
                  addAdminToSP(admin);
                });
              }
              Navigator.pushNamed(context, '/homeAdmin');
            } else if (isDoctor) {
              if (!prefs.containsKey('currentUserD')) {
                DoctorService().getByID(user.uid).then((cUser) {
                  Doctor doctor = Doctor.fromMap(cUser.data);
                  addDoctorToSP(doctor);
                });
              }
              Navigator.pushNamed(context, '/homeDoctor');
            } else if (isStudent) {
              if (!prefs.containsKey('currentUserS')) {
                StudentService().getByID(user.uid).then((cUser) {
                  Student student = Student.fromMap(cUser.data);
                  addStudentToSP(student);
                });
              }
              _setDailyTimeToSharedPrefs(user.uid);

              Navigator.pushNamed(context, '/studentMain');
            }
          });
        });
      } else {
        log('Current User is null');
        Navigator.pushNamed(context, '/welcome');
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
