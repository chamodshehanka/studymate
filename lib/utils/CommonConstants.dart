import 'package:flutter/cupertino.dart';

class CommonConstants extends InheritedWidget {
  static CommonConstants of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CommonConstants);

  // Collections Names
  static final String activityCollectionName = 'Activities';
  static final String activityProgressCollectionName = 'ActivityProgress';
  static final String doctorCollectionName = 'doctors';
  static final String studentsCollectionName = 'students';
  static final String medicalRecordCollection = 'medicalRecord';

  // Cloud Functions Names
  static final String addAdminFunction = 'addAdmin';
  static final String addDoctorFunction = 'addDoctor';
  static final String addStudentFunction = 'addStudent';
  static final String activityProgressFunction = 'activityProgress';

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
