
import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/ScheduleTask.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';

class ReportGeneration extends StatefulWidget {
  

   _ReportGenerationState createState() => _ReportGenerationState();
}

class _ReportGenerationState extends State<ReportGeneration> {
  int noOfAllTasks = 0;
  int noOfProgressRemaining = 0;
  int noOfCompleted = 0;
  int noOfProgressLeisure=0;
  int noOfProgressSocial=0;
  int noOfProgressStudy=0;
  String studentId;
  String day;
  String date;
  BaseAuthentication baseAuthentication = Authentication();
  ScheduleService scheduleService = new ScheduleService();
  List<ScheduleTask> dailyTasks = List();
  List taskProgress = List();
  List<String> notCompleted = List();
  
  @override
  void initState() {
    super.initState();
    baseAuthentication.getCurrentUser().then((user) {
      setState(() {
         DateTime d = DateTime.now();
         date = (d.year.toString()+"-"+d.month.toString()+"-"+d.day.toString());
        studentId = user.toString();
        int today = DateTime.now().weekday;
          switch(today){
          
          case 1:day = "monday";
            break;
          case 2:day = "tuesday";
            break;
          case 3:day = "wednesday";
            break;
          case 4:day = "thursday";
            break;
          case 5:day = "friday";
            break;
          case 6:day = "saturday";
            break;
          case 7:day = "sunday";
            break;
        }
      });

      getActivities().then((task){
        setState(() {
          noOfAllTasks = task.length;
        });

      getSocialProgress().then((task){

         setState(() {
          noOfProgressSocial = task.length;
          task.forEach((snapsot){
              if(snapsot.data["completed"] == snapsot.data["scheduled"]){
                noOfCompleted += 1;
              }
              if(((snapsot.data["scheduled"] - snapsot.data["completed"])/snapsot.data["scheduled"] * 100 > 40)){
                  notCompleted.add(snapsot.documentID);
              }
          });
        });
      });

       getLeisureProgress().then((task){

         setState(() {
          noOfProgressLeisure = task.length;
             task.forEach((snapsot){
              if(snapsot.data["completed"] == snapsot.data["scheduled"]){
                noOfCompleted += 1;
              }
                if(((snapsot.data["scheduled"] - snapsot.data["completed"])/snapsot.data["scheduled"] * 100 > 40)){
                  notCompleted.add(snapsot.documentID);
              }
          });
        });
      });

       getStudyProgress().then((task){

         setState(() {
          noOfProgressStudy = task.length;
             task.forEach((snapsot){
              if(snapsot.data["completed"] == snapsot.data["scheduled"]){
                noOfCompleted += 1;
              }
                if(((snapsot.data["scheduled"] - snapsot.data["completed"])/snapsot.data["scheduled"] * 100 > 40)){
                  notCompleted.add(snapsot.documentID);
              }
          });
        });
      });
          
      });
     
      });





  }

  Future<List<DocumentSnapshot>> getActivities()async{

  var data = await Firestore.instance
  .collection("students")
  .document(studentId)
  .collection("schedule")
  .document("weeklyschedule")
  .collection(day)
  .getDocuments();


  return data.documents;

}

Future<List<DocumentSnapshot>> getLeisureProgress()async{
log(date);
  var data = await Firestore.instance
  .collection("dailyLogs")
  .document(studentId)
  .collection(date)
  .document(date)
  .collection("tasks")
  .document("tasks")
  .collection("Leisure")
  .getDocuments();


  return data.documents;

}

Future<List<DocumentSnapshot>> getSocialProgress()async{
log(date);
  var data = await Firestore.instance
  .collection("dailyLogs")
  .document(studentId)
  .collection(date)
  .document(date)
  .collection("tasks")
  .document("tasks")
  .collection("Social")
  .getDocuments();


  return data.documents;

}

Future<List<DocumentSnapshot>> getStudyProgress()async{
log(date);
  var data = await Firestore.instance
  .collection("dailyLogs")
  .document(studentId)
  .collection(date)
  .document(date)
  .collection("tasks")
  .document("tasks")
  .collection("Study")
  .getDocuments();


  return data.documents;

}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: FabCircularMenu(
          child: Container(
           
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Text("Daily Report",textAlign: TextAlign.center,style: TextStyle(color: Colors.deepPurple,fontSize: 35.0,fontWeight: FontWeight.bold),),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                
                                Text("Total Tasks",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10.0,),
                                Text(noOfAllTasks.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 70.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            color: Colors.deepPurple,
                          ),
                          height: 150.0,
                          width:100.0
                        ),
                      ),

                         Expanded(
                        child: Container(
                          child:  Card(
                            child: Column(
                              children: <Widget>[
                                Text("Progress Submitted",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10.0,),
                                Text((noOfProgressSocial+noOfProgressLeisure+noOfProgressStudy).toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 70.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            color: Colors.amber,
                          ),
                          height: 150.0,
                          width:100.0
                        ),
                      ),
                    ],
                  ),

                    Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Text("Tasks Without Progress",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10.0,),
                                Text((noOfAllTasks-(noOfProgressLeisure+noOfProgressStudy+noOfProgressSocial)).toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 70.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            color: Colors.red,
                          ),
                          height: 150.0,
                          width:100.0
                        ),
                      ),

                         Expanded(
                        child: Container(
                          child:  Card(
                            child: Column(
                              children: <Widget>[
                                Text("Successfully Completed",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10.0,),
                                Text(noOfCompleted.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 70.0,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            color: Colors.green,
                          ),
                          height: 150.0,
                          width:100.0
                        ),
                      ),
                    ],
                  ),
                  Row(children: <Widget>[
                    Text("Suggessions To Discuss With Doctor",textAlign: TextAlign.center,style: TextStyle(color: Colors.deepPurple,fontSize: 20.0,fontWeight: FontWeight.bold),),
                  
                     
                  ],),
                     for(var item in notCompleted ) 

                     Padding(
                       padding: EdgeInsets.all(25.0),
                       child: Text(item,textAlign: TextAlign.center,style: TextStyle(color: Colors.deepPurple,fontSize: 20.0,fontWeight: FontWeight.bold),),
                       
                     ),
                ],
              ),
                      
            
    
    ),
          ringColor: Colors.deepPurple,
          ringDiameter: 200.0,
          ringWidth: 60.0,
          options: <Widget>[
            IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  Navigator.pushNamed(context, '/daily');
                },
                iconSize: 30.0,
                color: Colors.white),
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushNamed(context, '/studentMain');
                },
                iconSize: 30.0,
                color: Colors.white),
            IconButton(
                icon: Icon(Icons.schedule),
                onPressed: () {},
                iconSize: 30.0,
                color: Colors.white),
            IconButton(
                icon: Icon(Icons.chat),
                onPressed: () {},
                iconSize: 30.0,
                color: Colors.white),
            IconButton(
                icon: Icon(Icons.track_changes),
                onPressed: () {
                  Navigator.pushNamed(context, '/studentDailyReport');
                },
                iconSize: 30.0,
                color: Colors.white),
          ],
        ),
      ),
    );
  }
}