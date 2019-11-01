import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivityDashboardUI.dart';
import 'package:studymate/screens/ActivityScreen/ActivityProgressUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ActivityAdminDashboardUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ActivityReportUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/AdminActivityUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ManageActivityUI.dart';
import 'package:studymate/screens/ChatScreen/ChatUI.dart';
import 'package:studymate/screens/HomeScreen/HomeUIAdmin.dart';
import 'package:studymate/screens/HomeScreen/HomeUIDoctor.dart';
import 'package:studymate/screens/MainScreenStudent.dart';
import 'package:studymate/screens/MedicalRecordsScreen/CreateMedicalRecordUI.dart';
import 'package:studymate/screens/MedicalRecordsScreen/MedicalRecordUI.dart';
import 'package:studymate/screens/ScheduleScreen/Reports/DailyReportGeneration.dart';
import 'package:studymate/screens/StudentScreen/AccountTypeUI.dart';
import 'package:studymate/screens/StudentScreen/changePassword.dart';
import 'package:studymate/screens/StudentScreen/forgot_password.dart';
import 'package:studymate/screens/StudentScreen/nonSchoolStudentAddDetails.dart';
import 'package:studymate/screens/StudentScreen/schoolStudentAddDetails.dart';
import 'package:studymate/screens/StudentScreen/studentProfileUI.dart';
import 'package:studymate/screens/UserScreen.dart/AdminAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/DoctorAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/StudentAddForm.dart';
import 'package:studymate/screens/WelcomeScreen/SignInUI.dart';
import 'package:studymate/screens/WelcomeScreen/SignUpUI.dart';
import 'package:studymate/screens/WelcomeScreen/SplashScreen.dart';
import 'package:studymate/screens/WelcomeScreen/WelcomeUI.dart';

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
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/accountType':
        return MaterialPageRoute(builder: (_) => AccountTypeScreen());
      case '/activityDashboard':
        return MaterialPageRoute(builder: (_) => ActivityDashboardScreen());
      case '/adminActivityDashboard':
        return MaterialPageRoute(
            builder: (_) => ActivityAdminDashboardScreen());
      case '/adminActivityList':
        return MaterialPageRoute(builder: (_) => AdminActivityListScreen());
      case '/manageActivity':
        return MaterialPageRoute(
            builder: (_) => ManageActivityScreen(activity: null));
      case '/activityProgress':
        return MaterialPageRoute(builder: (_) => ActivityProgressScreen());
      case '/activityReports':
        return MaterialPageRoute(builder: (_) => ActivityReportScreen());
      case '/homeDoctor':
        return MaterialPageRoute(builder: (_) => HomeScreenDoctor());
      case '/homeAdmin':
        return MaterialPageRoute(builder: (_) => HomeScreenAdmin());
      case '/forgotPassword':
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case '/medicalRecord':
        return MaterialPageRoute(builder: (_) => MedicalRecordUIScreen());
      case '/createMedicalRecord':
        return MaterialPageRoute(builder: (_) => CreateMedicalRecordScreen());
      case '/chat':
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case '/schoolStudentAddDetails':
        return MaterialPageRoute(
            builder: (_) => SchoolStudentAddDetailsScreen());
      case '/nonSchoolStudentAddDetails':
        return MaterialPageRoute(
            builder: (_) => NonSchoolStudentAddDetailsScreen());
      case '/profileUI':
        return MaterialPageRoute(builder: (_) => ProfileUIScreen());
      case '/doctorAdd':
        return MaterialPageRoute(builder: (_) => DoctorAddScreen());
      case '/studentAdd':
        return MaterialPageRoute(builder: (_) => StudentAddScreen());
      case '/adminAdd':
        return MaterialPageRoute(builder: (_) => AdminAddScreen());
      case '/changePassword':
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case '/studentMain':
        return MaterialPageRoute(builder: (_) => StudentMainScreen());
      case '/studentDailyReport':
        return MaterialPageRoute(builder: (_) => ReportGeneration());
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
