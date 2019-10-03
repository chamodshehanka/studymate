import 'dart:async';


import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';

class MondayTab extends StatefulWidget {
  MondayTab();
  

  @override
  _MondayTabState createState() => _MondayTabState();
}

class _MondayTabState extends State<MondayTab> {
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