import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import "package:carousel_slider/carousel_slider.dart";
import 'package:studymate/ScheduleManager/CalendarEvents.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';

//import 'CalendarEvents.dart';

class CreateSchedule extends StatefulWidget {
  final int id;
  
  
  CreateSchedule({Key key, this.id}) : super(key: key);
  @override
  _CreateScheduleState createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  ScheduleService scheduleService =  new ScheduleService();
  Future<Calendar> futureCalendar;
  Calendar calendar;
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  List<String> days = new List();
  CarouselSlider instance;
  @override
  void initState() {
    super.initState();
    days.add("Sunday");
    days.add("Monday");
    days.add("Tuesday");
    days.add("Wednesday");
    days.add("Thursday");
    days.add("Friday");
    days.add("Saturday");
    
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

    instance = new CarouselSlider(
      initialPage: widget.id,
      items: days.map((d) {
        return new Container(
            width: 400,
            margin: new EdgeInsets.symmetric(horizontal: 5.0),
            decoration: new BoxDecoration(color: Colors.amber),
            child: Stack(
              children: <Widget>[
                Text(d),
              
      
        CalendarEventsPage(calendar,d),
        
              ],
            ));
      }).toList(),
      height: 550,
      autoPlay: false,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("StudyMate"),
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        body: instance);
  }
}

class Data {
  int id;
  Data(int id) {
    this.id = id;
  }
}