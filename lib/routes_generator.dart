import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesUI.dart';
import 'package:studymate/screens/AppoinmentScreen/Appointment.dart';
import 'package:studymate/screens/HomeScreen/HomeUI.dart';
import 'package:studymate/screens/RewardScreen/badge.dart';
import 'package:studymate/screens/RewardScreen/rewards.dart';
import 'package:studymate/screens/ScheduleScreen/createSchedule.dart';
import 'package:studymate/screens/ScheduleScreen/daily.dart';
import 'package:studymate/screens/StudentScreen/AccountTypeUI.dart';
import 'package:studymate/screens/StudentScreen/add.dart';
import 'package:studymate/screens/StudentScreen/signup1.dart';
import 'package:studymate/screens/WelcomeScreen/WelcomeUI.dart';
import 'package:studymate/screens/WelcomeScreen/signin.dart';
import 'package:studymate/screens/WelcomeScreen/signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/signup1':
        return MaterialPageRoute(builder: (_) => SignUp1Screen());
      case '/accounttype':
        return MaterialPageRoute(builder: (_) => AccountTypeScreen());
      case '/add': //WTF is 'add' Suranga?
        return MaterialPageRoute(builder: (_) => AddScreen());
      case '/daily':
        return MaterialPageRoute(builder: (_) => DailyScreen());
      case '/activity':
        return MaterialPageRoute(builder: (_) => ActivityScreen());
      case '/appointment':
        return MaterialPageRoute(builder: (_) => AppointmentScreen());
      case '/badge':
        return MaterialPageRoute(builder: (_) => BadgesScreen());
      case '/rewards':
        return MaterialPageRoute(builder: (_) => RewardsScreen());
      case 'createSchedule':
        return MaterialPageRoute(builder: (_) => CreateSchedule());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR!'),
        ),
      );
    });
  }
}
