import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesUI.dart';
import 'package:studymate/screens/ScheduleScreen/WeeklyPlanScreen.dart';
import 'package:studymate/screens/StudentScreen/studentProfileUI.dart';

import 'HomeScreen/HomeUI.dart';

class StudentPlaceholder extends StatefulWidget {
  final int index;

  StudentPlaceholder(this.index);
  _StudentPlaceholderState createState() => _StudentPlaceholderState();
}

class _StudentPlaceholderState extends State<StudentPlaceholder> {
  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return WeeklyPlanScreen();
        break;

      case 2:
        return ActivityScreen();
        break;

      default:
        return ProfileUIScreen();
    }
  }
}
