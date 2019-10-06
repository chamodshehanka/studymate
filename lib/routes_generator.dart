import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesUI.dart';
import 'package:studymate/screens/ActivityScreen/ActivityDashboardUI.dart';
import 'package:studymate/screens/ActivityScreen/ActivityProgressUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ActivityAdminDashboardUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ActivityReportUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/AdminActivityUI.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/ManageActivityUI.dart';
//import 'package:studymate/screens/AppoinmentScreen/Appointment.dart';
import 'package:studymate/screens/ChatScreen/ChatUI.dart';
import 'package:studymate/screens/AppointmentScreen/Doctor/AppointmentReportUI.dart';
//import 'package:studymate/screens/DoctorAppointmentScreen/AppointmentWelcome.dart';
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
import 'package:studymate/screens/RewardScreen/achievments.dart';
import 'package:studymate/screens/ScheduleScreen/DailySchedule.dart';
import 'package:studymate/screens/ScheduleScreen/Reports/ReportGeneration.dart';
import 'package:studymate/screens/ScheduleScreen/WeeklyPlanScreen.dart';
import 'package:studymate/screens/StudentMainScreen.dart';
import 'package:studymate/screens/StudentScreen/AccountTypeUI.dart';
import 'package:studymate/screens/StudentScreen/changePassword.dart';
import 'package:studymate/screens/StudentScreen/forgot_password.dart';
import 'package:studymate/screens/StudentScreen/nonSchoolStudentAddDetails.dart';
import 'package:studymate/screens/StudentScreen/schoolStudentAddDetails.dart';
import 'package:studymate/screens/StudentScreen/studentProfileUI.dart';
import 'package:studymate/screens/TestUI.dart';
import 'package:studymate/screens/UserScreen.dart/AdminAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/DoctorAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/StudentAddForm.dart';
import 'package:studymate/screens/WelcomeScreen/SignInUI.dart';
import 'package:studymate/screens/WelcomeScreen/SignUpUI.dart';
import 'package:studymate/screens/WelcomeScreen/SplashScreen.dart';
import 'package:studymate/screens/WelcomeScreen/WelcomeUI.dart';
<<<<<<< HEAD
import 'package:studymate/screens/SubjectsScreen/SubjectUI.dart';
import 'package:studymate/screens/SubjectsScreen/SubjectProgressUI.dart';
import 'package:studymate/screens/SubjectsScreen/SubjectDashboardUI.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/AdminSubjectUI.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/ManageSubjectUI.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/SubjectReportUI.dart';
import 'package:studymate/screens/SubjectsScreen/AdminScreen/SubjectAdminDashboardUI.dart';
=======
import 'package:studymate/screens/SubjectsScreen/UDSubjectUI.dart';
import 'package:studymate/screens/AppointmentScreen/Doctor/AppointmentWelcome.dart';
>>>>>>> 83812c04f34ca25dd55489e87beadcd536657f42

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
      case '/accountType':
        return MaterialPageRoute(builder: (_) => AccountTypeScreen());
      case '/daily':
<<<<<<< HEAD
        return MaterialPageRoute(builder: (_) => DailyScreen());
      case '/subjectDashboard':
        return MaterialPageRoute(builder: (_) => SubjectDashboardScreen());
=======
        return MaterialPageRoute(builder: (_) => DailyScheduleScreen());
>>>>>>> 83812c04f34ca25dd55489e87beadcd536657f42
      case '/activityDashboard':
        return MaterialPageRoute(builder: (_) => ActivityDashboardScreen());
      case '/adminSubjectDashboard':
        return MaterialPageRoute(
            builder: (_) => SubjectAdminDashboardScreen());
      case '/adminActivityDashboard':
        return MaterialPageRoute(
            builder: (_) => ActivityAdminDashboardScreen());
       case '/subject':
        return MaterialPageRoute(builder: (_) => SubjectsScreen());     
      case '/activity':
        return MaterialPageRoute(builder: (_) => ActivityScreen());
      case '/adminSubjectList':
        return MaterialPageRoute(builder: (_) => AdminSubjectListScreen());
      case '/adminActivityList':
        return MaterialPageRoute(builder: (_) => AdminActivityListScreen());
      case '/manageSubject':
        return MaterialPageRoute(
            builder: (_) => ManageSubjectScreen(subject: null));
      case '/manageActivity':
        return MaterialPageRoute(
            builder: (_) => ManageActivityScreen(activity: null));
      case '/subjectProgress':
        return MaterialPageRoute(builder: (_) => SubjectProgressScreen());
      case '/activityProgress':
        return MaterialPageRoute(builder: (_) => ActivityProgressScreen());
      case '/subjectReports':
        return MaterialPageRoute(builder: (_) => SubjectReportScreen());
      case '/activityReports':
        return MaterialPageRoute(builder: (_) => ActivityReportScreen());
/*      case '/appointment':
        return MaterialPageRoute(builder: (_) => AppointmentScreen());*/
      case '/DoctorAppointmentScreen':
        return MaterialPageRoute(builder: (_) => DoctorAppointmentScreen());
      case '/appointmentReports':
        return MaterialPageRoute(builder: (_) => AppointmentReportScreen());
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
      case '/achievments':
        return MaterialPageRoute(builder: (_) => AchievmentsScreen());
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
      case '/testUI':
        return MaterialPageRoute(builder: (_) => TestUIScreen());
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
      case '/weeklySchedule':
        return MaterialPageRoute(builder: (_) => WeeklyPlanScreen());
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
