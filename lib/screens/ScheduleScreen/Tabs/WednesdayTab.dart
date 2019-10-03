import 'dart:async';


import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';

class WednesdayTab extends StatefulWidget {

  WednesdayTab();
  

  @override
  _WednesdayTabState createState() => _WednesdayTabState();
}

class _WednesdayTabState extends State<WednesdayTab> {
  ScheduleService scheduleService =  new ScheduleService();
  Future<Calendar> futureCalendar;
  Calendar calendar;
  @override
  void initState() {
    super.initState();


   futureCalendar = scheduleService.selectCalendar();
    
    futureCalendar.then((value){
      calendar = value;
      setState(() {
        calendar = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white10,
     
    );
  }

}