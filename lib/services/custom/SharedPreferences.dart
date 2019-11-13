import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymate/models/Admin.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/models/Student.dart';

addStudentToSP(Student student) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('currentuserS', student.id);
  prefs.setString('fnameS', student.firstName);
  prefs.setString('lnameS', student.lastName);
}

addDoctorToSP(Doctor doctor) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('currentuserD', doctor.id);
  prefs.setString('fnameD', doctor.firstName);
  prefs.setString('lnameD', doctor.lastName);
}

addAdminToSP(Admin admin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('currentuserA', admin.id);
  prefs.setString('fnameA', admin.firstName);
  prefs.setString('lnameA', admin.lastName);
}

addScheduleTimeFriday(int social, int leisure, int study) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('socialFri', social);
  prefs.setInt('leisureFri', leisure);
  prefs.setInt('studyFri', study);
}

addScheduleTimeSaturday(int social, int leisure, int study) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('socialSat', social);
  prefs.setInt('leisureSat', leisure);
  prefs.setInt('studySat', study);
}

addScheduleTimeSunday(int social, int leisure, int study) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('socialSun', social);
  prefs.setInt('leisureSun', leisure);
  prefs.setInt('studySun', study);
}

addScheduleTimeMonday(int social, int leisure, int study) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('socialMon', social);
  prefs.setInt('leisureMon', leisure);
  prefs.setInt('studyMon', study);
}

addScheduleTimeTuesday(int social, int leisure, int study) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('socialTue', social);
  prefs.setInt('leisureTue', leisure);
  prefs.setInt('studyTue', study);
}

addScheduleTimeWednesday(int social, int leisure, int study) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('socialWed', social);
  prefs.setInt('leisureWed', leisure);
  prefs.setInt('studyWed', study);
}

addScheduleTimeThursday(int social, int leisure, int study) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('socialThu', social);
  prefs.setInt('leisureThu', leisure);
  prefs.setInt('studyThu', study);
}
