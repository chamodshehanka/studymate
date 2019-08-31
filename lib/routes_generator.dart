import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/AdminActivityUI.dart';
import 'package:studymate/screens/AppoinmentScreen/Appointment.dart';
import 'package:studymate/screens/HomeScreen/HomeUI.dart';
import 'package:studymate/screens/HomeScreen/HomeUIAdmin.dart';
import 'package:studymate/screens/HomeScreen/HomeUIDoctor.dart';
import 'package:studymate/screens/MedicalRecordsScreen/MedicalRecordUI.dart';
import 'package:studymate/screens/RewardScreen/Admin/new_badge.dart';
import 'package:studymate/screens/RewardScreen/Admin/badge_collection.dart';
import 'package:studymate/screens/RewardScreen/s_reward.dart';
import 'package:studymate/screens/RewardScreen/rewards.dart';
import 'package:studymate/screens/ScheduleScreen/ScheduleManagerMain.dart';
import 'package:studymate/screens/ScheduleScreen/createSchedule.dart';
import 'package:studymate/screens/ScheduleScreen/daily.dart';
import 'package:studymate/screens/StudentScreen/AccountTypeUI.dart';
import 'package:studymate/screens/StudentScreen/add.dart';
import 'package:studymate/screens/StudentScreen/signup.dart';
import 'package:studymate/screens/StudentScreen/signup1.dart';
import 'package:studymate/screens/TestUI.dart';
import 'package:studymate/screens/WelcomeScreen/WelcomeUI.dart';
import 'package:studymate/screens/WelcomeScreen/signin.dart';
import 'package:studymate/screens/SubjectsScreen/SubjectUI.dart';
import 'package:studymate/screens/SubjectsScreen/UDSubjectUI.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

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
      case '/adminActivity':
        return MaterialPageRoute(builder: (_) => AdminActivityScreen());
      case '/appointment':
        return MaterialPageRoute(builder: (_) => AppointmentScreen());
      case '/new_badge':
        return MaterialPageRoute(builder: (_) => NewBadgeScreen());
      case '/badge_collection':
        return MaterialPageRoute(builder: (_) => BadgesScreen());
      case '/rewards':
        return MaterialPageRoute(builder: (_) => RewardsScreen());
      case '/s_rewards':
        return MaterialPageRoute(builder: (_) => StudentRewardsScreen());
      case '/homeDoctor':
        return MaterialPageRoute(builder: (_) => HomeScreenDoctor());
      case '/homeAdmin':
        return MaterialPageRoute(builder: (_) => HomeScreenAdmin());
      case '/medicalRecord':
        return MaterialPageRoute(builder: (_) => MedicalRecordUIScreen());
      case '/scheduleManager':
        return MaterialPageRoute(builder: (_) => ScheduleManagerHome());
      case '/createdSchedule':
        return MaterialPageRoute(builder: (_) => CreateSchedule());
      case '/subject':
        return MaterialPageRoute(builder: (_) => SubjectsScreen());
      case '/testUI':
        return MaterialPageRoute(builder: (_) => TestUIScreen());
        case '/udSubject':
        return MaterialPageRoute(builder: (_) => SubjectsScreen());

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
