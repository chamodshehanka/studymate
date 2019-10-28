import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesListUI.dart';
import 'package:studymate/screens/HomeScreen/HomeUI.dart';
import 'package:studymate/screens/ScheduleScreen/WeeklyPlanScreen.dart';
import 'package:studymate/screens/StudentScreen/studentProfileUI.dart';

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
        return ActivityListScreen();
        break;

      default:
        return ProfileUIScreen();
    }
  }
}
