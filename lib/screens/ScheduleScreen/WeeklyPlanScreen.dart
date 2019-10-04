import 'package:flutter/material.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/FridayTab.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/MondayTab.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/SaturdayTab.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/SundayTab.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/ThursdayTab.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/TuesdayTab.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/WednesdayTab.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';


class WeeklyPlanScreen extends StatefulWidget {
  _WeeklyPlanScreenState createState() => _WeeklyPlanScreenState();
  
}



class _WeeklyPlanScreenState extends State<WeeklyPlanScreen> {
    ScheduleService scheduleService =  new ScheduleService();
 
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Weekly Schedule",
            ),
            backgroundColor: Colors.deepPurple,
            centerTitle:true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "SUN"),
                Tab(text: "MON"),
                Tab(text: "TUE"),
                Tab(text: "WED"),
                Tab(text: "THU"),
                Tab(text: "FRI"),
                Tab(text: "SAT"),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              SundayTab(),
              MondayTab(),
              TuesdayTab(),
              WednesdayTab(),
              ThursdayTab(),
              FridayTab(),
              SaturdayTab(),
            ],
          ),
         ),
      ),
    );
  }
}
