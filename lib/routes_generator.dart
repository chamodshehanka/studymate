import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesUI.dart';
import 'package:studymate/screens/ActivityScreen/ActivityDashboardUI.dart';
import 'package:studymate/screens/ActivityScreen/ActivityProgressUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ActivityAdminDashboardUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/AdminActivityUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ManageActivityUI.dart';
import 'package:studymate/screens/AppoinmentScreen/Appointment.dart';
import 'package:studymate/screens/ChatScreen/ChatUI.dart';
import 'package:studymate/screens/DoctorAppointmentScreen/AppointmentWelcome.dart';
import 'package:studymate/screens/HomeScreen/HomeUI.dart';
import 'package:studymate/screens/HomeScreen/HomeUIAdmin.dart';
import 'package:studymate/screens/HomeScreen/HomeUIDoctor.dart';
import 'package:studymate/screens/MedicalRecordsScreen/CreateMedicalRecordUI.dart';
import 'package:studymate/screens/MedicalRecordsScreen/MedicalRecordUI.dart';
import 'package:studymate/screens/RewardScreen/Admin/new_badge.dart';
import 'package:studymate/screens/RewardScreen/badges.dart';
import 'package:studymate/screens/RewardScreen/Admin/badge_collection.dart';
import 'package:studymate/screens/RewardScreen/s_reward.dart';
import 'package:studymate/screens/RewardScreen/Admin/rewards.dart';
import 'package:studymate/screens/RewardScreen/Admin/image_bank.dart';
import 'package:studymate/screens/RewardScreen/achievments.dart';
import 'package:studymate/screens/ScheduleScreen/ScheduleManagerMain.dart';
import 'package:studymate/screens/ScheduleScreen/CreateSchedule.dart';
import 'package:studymate/screens/ScheduleScreen/Daily.dart';
import 'package:studymate/screens/StudentScreen/AccountTypeUI.dart';
import 'package:studymate/screens/StudentScreen/studentAddDetails.dart';
import 'package:studymate/screens/StudentScreen/studentProfileUI.dart';
import 'package:studymate/screens/SubjectsScreen/SubjectUI.dart';
import 'package:studymate/screens/TestUI.dart';
import 'package:studymate/screens/UserScreen.dart/AdminAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/DoctorAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/StudentAddForm.dart';
import 'package:studymate/screens/WelcomeScreen/SignInUI.dart';
import 'package:studymate/screens/WelcomeScreen/SignUpUI.dart';
import 'package:studymate/screens/WelcomeScreen/SplashScreen.dart';
import 'package:studymate/screens/WelcomeScreen/WelcomeUI.dart';
import 'package:studymate/screens/SubjectsScreen/UDSubjectUI.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/accounttype':
        return MaterialPageRoute(builder: (_) => AccountTypeScreen());
      case '/daily':
        return MaterialPageRoute(builder: (_) => DailyScreen());
      case '/activityDashboard':
        return MaterialPageRoute(builder: (_) => ActivityDashboardScreen());
      case '/adminActivityDashboard':
        return MaterialPageRoute(
            builder: (_) => ActivityAdminDashboardScreen());
      case '/activity':
        return MaterialPageRoute(builder: (_) => ActivityScreen());
      case '/adminActivityList':
        return MaterialPageRoute(builder: (_) => AdminActivityListScreen());
      case '/manageActivity':
        return MaterialPageRoute(
            builder: (_) => ManageActivityScreen(activity: null));
      case '/activityProgress':
        return MaterialPageRoute(builder: (_) => ActivityProgressScreen());
      case '/appointment':
        return MaterialPageRoute(builder: (_) => AppointmentScreen());
      case '/AppointmentWelcome':
        return MaterialPageRoute(builder: (_) => DoctorAppointmentScreen());
      case '/new_badge':
        return MaterialPageRoute(builder: (_) => NewBadgeScreen());
      case '/badge_collection':
        return MaterialPageRoute(builder: (_) => BadgesScreen());
      case '/badges':
        return MaterialPageRoute(builder: (_) => SBadgesScreen());
      case '/rewards':
        return MaterialPageRoute(builder: (_) => RewardsScreen());
      case '/s_rewards':
        return MaterialPageRoute(builder: (_) => StudentRewardsScreen());
      case '/image_bank':
        return MaterialPageRoute(builder: (_) => ImagesScreen());
      case '/achievments':
        return MaterialPageRoute(builder: (_) => AchievmentsScreen());
      case '/homeDoctor':
        return MaterialPageRoute(builder: (_) => HomeScreenDoctor());
      case '/homeAdmin':
        return MaterialPageRoute(builder: (_) => HomeScreenAdmin());
      case '/medicalRecord':
        return MaterialPageRoute(builder: (_) => MedicalRecordUIScreen());
      case '/createMedicalRecord':
        return MaterialPageRoute(builder: (_) => CreateMedicalRecordScreen());
      case '/scheduleManager':
        return MaterialPageRoute(builder: (_) => ScheduleManagerHome());
      case '/createdSchedule':
        return MaterialPageRoute(builder: (_) => CreateSchedule());
      case '/chat':
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case '/studentAddDetails':
        return MaterialPageRoute(builder: (_) => StudentAddDetailsScreen());  
      case '/subject':
        return MaterialPageRoute(builder: (_) => SubjectsScreen());
      case '/testUI':
        return MaterialPageRoute(builder: (_) => TestUIScreen());
      case '/profileUI':
        return MaterialPageRoute(builder: (_) => ProfileUIScreen());
      case '/udSubject':
        return MaterialPageRoute(builder: (_) => UDSubjectUI());  
      case '/doctorAdd':
        return MaterialPageRoute(builder: (_) => DoctorAddScreen());
      case '/studentAdd':
        return MaterialPageRoute(builder: (_) => StudentAddScreen()); 
      case '/adminAdd':
        return MaterialPageRoute(builder: (_) => AdminAddScreen());    
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
