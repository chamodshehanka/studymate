import 'package:flutter/material.dart';
// import 'package:studymate/main.dart';
import 'package:studymate/screens/Appointment.dart';
import 'package:studymate/screens/accounttype.dart';
import 'package:studymate/screens/add.dart';
import 'package:studymate/screens/badge.dart';
import 'package:studymate/screens/createSchedule.dart';
import 'package:studymate/screens/daily.dart';
import 'package:studymate/screens/first.dart';
import 'package:studymate/screens/home.dart';
import 'package:studymate/screens/rewards.dart';
import 'package:studymate/screens/signin.dart';
import 'package:studymate/screens/signup.dart';
import 'package:studymate/screens/signup1.dart';
 
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
      case '/add': //WTF is add Suranga?
        return MaterialPageRoute(builder: (_) => AddScreen());
      case '/daily':
        return MaterialPageRoute(builder: (_) => DailyScreen());
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
