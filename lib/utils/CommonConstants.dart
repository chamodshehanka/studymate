import 'package:flutter/cupertino.dart';

class CommonConstants extends InheritedWidget {
  static CommonConstants of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CommonConstants);

  // Collections Names
  static final String activityCollectionName = 'Activities';
  static final String adminsCollectionName = 'admins';
  static final String preferredActivitiesCollectionName = 'preferredActivities';
  static final String socialActivitiesCollectionName = 'socialActivities';
  static final String leisureActivitiesCollectionName = 'leisureActivities';
  static final String activityProgressCollectionName = 'ActivityProgress';
  static final String doctorCollectionName = 'doctors';
  static final String studentsCollectionName = 'students';
  static final String medicalRecordCollection = 'medicalRecord';
  static final String scheduleCollection = 'schedule';
  static final String appointmentCollectionName = 'appointment';

  // Cloud Functions Names
  static final String addAdminFunction = 'addAdmin';
  static final String addDoctorFunction = 'addDoctor';
  static final String addStudentFunction = 'addStudent';
  static final String activityProgressFunction = 'activityProgress';
  static final String sendMessageToParent = 'sendMessageToParent';
  static final String cloudNotificatinFunction = 'cloudNotificatinFunction';

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
