import 'dart:async';


import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';

class ThursdayTab extends StatefulWidget {
  ThursdayTab();
 

  @override
  _ThursdayTabState createState() => _ThursdayTabState();
}

class _ThursdayTabState extends State<ThursdayTab> {
  ScheduleService scheduleService =  new ScheduleService();
  Future<Calendar> futureCalendar;
  Calendar calendar;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white10,
    
    );
  }

}