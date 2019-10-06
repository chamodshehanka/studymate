import 'dart:developer';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/DailyLeisureTab.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/DailySocialTab.dart';
import 'package:studymate/screens/ScheduleScreen/Tabs/DailyStudyTab.dart';




class DailyScheduleScreen extends StatefulWidget {
  _DailyScheduleScreenState createState() => _DailyScheduleScreenState();
  
}



class _DailyScheduleScreenState extends State<DailyScheduleScreen> {
   
 
  @override
  void initState() {
    super.initState();
    DateTime date =  DateTime.now();
      log((date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString()));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Today Schedule",
            ),
            backgroundColor: Colors.deepPurple,
            centerTitle:true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Study"),
                Tab(text: "Leisure"),
                Tab(text: "Social"),
              ],
            ),
          ),
          body: FabCircularMenu(
            child:   TabBarView(
            children: <Widget>[
              DailyStudyTab(),
              DailyLeisureTab(),
              DailySocialTab(),
           
            ],
          ),
          ringColor: Colors.deepPurple,
          ringDiameter: 200.0,
          ringWidth: 60.0,
          options: <Widget>[
            IconButton(icon: Icon(Icons.home), onPressed: () {Navigator.pushNamed(context, '/studentMain');}, iconSize: 30.0, color: Colors.white),
            IconButton(icon: Icon(Icons.calendar_today), onPressed: () {}, iconSize: 30.0, color: Colors.white),
            IconButton(icon: Icon(Icons.schedule), onPressed: () {}, iconSize: 30.0, color: Colors.white),
            IconButton(icon: Icon(Icons.chat), onPressed: () {}, iconSize: 30.0, color: Colors.white),
          ],
          )
          
        
         ),
      ),
    );
  }
}
