import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesListUI.dart';
import 'package:studymate/screens/HomeScreen/HomeUI.dart';
import 'package:studymate/screens/ScheduleScreen/WeeklyPlanScreen.dart';
import 'package:studymate/screens/StudentScreen/studentProfileUI.dart';

class PlaceholderWidget extends StatefulWidget {
  final int index;

  PlaceholderWidget(this.index);
  _PlaceHolderState createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<PlaceholderWidget> {
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
