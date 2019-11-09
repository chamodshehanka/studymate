import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivityDashboardUI.dart';
import 'package:studymate/screens/ActivityScreen/ActivityProgressUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ActivityAdminDashboardUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ActivityReportUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/AdminActivityUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ManageActivityUI.dart';
import 'package:studymate/screens/AppointmentScreen/doctor/DoctorAppointmentDashboardUI.dart';
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
import 'package:studymate/screens/SubjectsScreen/AdminScreen/SubjectAdminDashboard.dart';
import 'package:studymate/screens/UserScreen.dart/AdminManager.dart';
import 'package:studymate/screens/UserScreen.dart/DoctorManager.dart';
import 'package:studymate/screens/UserScreen.dart/StudentManager.dart';
import 'package:studymate/screens/UserScreen.dart/UserManager.dart';
import 'package:studymate/screens/WelcomeScreen/SignInUI.dart';
import 'package:studymate/screens/WelcomeScreen/SignUpUI.dart';
import 'package:studymate/screens/WelcomeScreen/SplashScreen.dart';
import 'package:studymate/screens/WelcomeScreen/WelcomeUI.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/AdminSubjectUI.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/ManageSubjectUI.dart';
import 'package:studymate/screens/RewardScreen/AdminScreen/AdminBadgeListUI.dart';
import 'package:studymate/screens/RewardScreen/AdminScreen/AddBadge.dart';

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
       case '/adminSubjectDashboard':
        return MaterialPageRoute(
            builder: (_) => SubjectAdminDashboardScreen());
      case '/adminActivityList':
        return MaterialPageRoute(builder: (_) => AdminActivityListScreen());
      case '/manageActivity':
        return MaterialPageRoute(
            builder: (_) => ManageActivityScreen(activity: null));
      case '/activityProgress':
        return MaterialPageRoute(builder: (_) => ActivityProgressScreen());
      case '/activityReports':
        return MaterialPageRoute(builder: (_) => ActivityReportScreen());
      case '/adminSubjectList':
        return MaterialPageRoute(builder: (_) => AdminSubjectListScreen());
      case '/manageSubject':
        return MaterialPageRoute(
            builder: (_) => ManageSubjectScreen(subject: null));
      case '/adminBadgeList':
        return MaterialPageRoute(builder: (_) => AdminBadgeListScreen());
      case '/adminCreateBadge':
        return MaterialPageRoute(builder: (_) => AddBadgeScreen());  
      case '/homeDoctor':
        return MaterialPageRoute(builder: (_) => HomeScreenDoctor());
      case '/homeAdmin':
        return MaterialPageRoute(builder: (_) => HomeScreenAdmin());
      case '/userManager':
        return MaterialPageRoute(builder: (_) => UserManagerScreen());
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
      case '/doctorManage':
        return MaterialPageRoute(builder: (_) => DoctorManagerScreen());
      case '/studentManage':
        return MaterialPageRoute(builder: (_) => StudentManagerScreen());
      case '/adminManage':
        return MaterialPageRoute(builder: (_) => AdminManagerScreen());
      case '/changePassword':
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case '/studentMain':
        return MaterialPageRoute(builder: (_) => StudentMainScreen());
      case '/studentDailyReport':
        return MaterialPageRoute(builder: (_) => ReportGeneration());
      case '/doctorAppointmentDashboard':
        return MaterialPageRoute(
            builder: (_) => DoctorAppointmentDashboardScreen());
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
