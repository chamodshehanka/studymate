import 'package:flutter/cupertino.dart';

class CommonConstants extends InheritedWidget {
  static CommonConstants of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CommonConstants);

  // Collections Names
  static final String activityCollectionName = 'Activities';
  static final String adminsCollectionName = 'admins';
  static final String preferredActivitiesCollectionName = 'preferredActivities';
  static final String socialActivitiesCollectionName = 'socialActivities';
  static final String subjectCollectionName = 'Subjects';
  static final String leisureActivitiesCollectionName = 'leisureActivities';
  static final String activityProgressCollectionName = 'ActivityProgress';
  static final String doctorCollectionName = 'doctors';
  static final String studentsCollectionName = 'students';
  static final String medicalRecordCollection = 'medicalRecord';
  static final String scheduleCollection = 'schedule';
  static final String dailylogCollection = 'dailyLogs';
  static final String appointmentCollectionName = 'Appointment';
  static final String preferredSubjectsCollectionName = 'preferredSubjects';
  static final String grade69SubjectsCollectionName = 'grade69';
  static final String olSubjectsCollectionName = 'ordinaryLevel';
  static final String alSubjectsCollectionName = 'advancedLevel';

  // Cloud Functions Names
  static final String addAdminFunction = 'addAdmin';
  static final String addDoctorFunction = 'addDoctor';
  static final String addStudentFunction = 'addStudent';
  static final String activityProgressFunction = 'activityProgress';
  static final String sendMessageToParent = 'sendMessageToParent';
  static final String cloudNotificatinFunction = 'cloudNotificatinFunction';

  //common data
  static final List<String> activityTypes = ["Leisure","Social","Other"];
  static final List<String> subjectTypes = ["Advanced Level","Ordinary Level","Grade 6","Grade 7","Grade 8","Grade 9"];
  static final List<String> scheduleTypes = ["Study","Leisure","Social"];

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
