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

 int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex){
        case 0 : Navigator.pushNamed(context, "/home");
                break;
        case 1 : Navigator.pushNamed(context, "/scheduleManager");
                break;
        case 2 : Navigator.pushNamed(context, "/activity");
                break;
        case 3 : Navigator.pushNamed(context, "/profileUI");                      

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CarouselSlider(
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
    ),
    bottomNavigationBar:  BottomNavigationBar(
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home,color: Colors.deepPurple),
           title: new Text('Home',style: TextStyle(color: Colors.deepPurple)),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.calendar_today,color: Colors.deepPurple),
           title: new Text('Schedule',style: TextStyle(color: Colors.deepPurple)),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.favorite,color: Colors.deepPurple),
           title: Text('Preferences',style: TextStyle(color: Colors.deepPurple))
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.account_circle,color: Colors.deepPurple),
           title: Text('Profile',style: TextStyle(color: Colors.deepPurple))
         )
       ],
       currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
    ),
    );
  }
}

class Data {
  int id;
  Data(int id) {
    this.id = id;
  }
}