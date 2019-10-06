
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studymate/models/ScheduleTask.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';
import 'package:studymate/services/custom/ScheduleServices.dart' as prefix0;
import 'package:studymate/services/custom/StudentService.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';


class DailyStudyTab extends StatefulWidget {
  DailyStudyTab();

  @override
  _DailyStudyTabState createState() => _DailyStudyTabState();
}

class _DailyStudyTabState extends State<DailyStudyTab> {
  ScheduleService scheduleService = new ScheduleService();
  StudentService studentService = new StudentService();
  
  BaseAuthentication baseAuthentication = Authentication();
  StreamSubscription<QuerySnapshot> dailyTaskSubscription;
  String studentId;
  String day;

  List<ScheduleTask> todayStudyTaskList = List();
  @override
  void initState() {
    super.initState();
    baseAuthentication.getCurrentUser().then((user) {
      setState(() {
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
      todayStudyTaskList = List();
      dailyTaskSubscription?.cancel();
      dailyTaskSubscription = scheduleService
          .getDailyStudyTaskList(studentId, day)
          .listen((QuerySnapshot snapshot) {
        final List<ScheduleTask> tasks = snapshot.documents
            .map((documentSnapshot) =>
                ScheduleTask.fromMap(documentSnapshot.data))
            .toList();
        setState(() {
          this.todayStudyTaskList = tasks;
        });
      });
      
    });
  }

  @override
  void dispose() {
    dailyTaskSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
Card makeCard(ScheduleTask studyTask) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Slidable(child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(studyTask),
          ),
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
            IconSlideAction(caption: 'Add Daily Progress',
            color: Colors.greenAccent,
            icon: Icons.create,
            onTap: ()=> addTaskProgress(studyTask),),
          ],)
         
        );

    final dailyStudyTabBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: todayStudyTaskList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(todayStudyTaskList[index]);
        },
      ),
    );
    return Scaffold(
      body: dailyStudyTabBody,
      backgroundColor: Colors.white10,
    );
  }
    void addTaskProgress(ScheduleTask task) {
        DateTime date = DateTime.now();

  

        String today = (date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString());
        DateTime start = DateTime.parse(task.start);
        DateTime end = DateTime.parse(task.end);
        Duration duration = end.difference(start);
  
         showDialog(
              context: context,
              builder: (_) {
                return AddProgressDialog(studentId,task,today,duration.inMinutes.toString());
              });
  }
}

buildTilesList(ScheduleTask task) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white30))),
      child: Text(
        DateTime.parse(task.start).hour.toString().padLeft(2, "0") +
            ":" +
            DateTime.parse(task.start).minute.toString().padLeft(2, "0") +
            " - " +
            DateTime.parse(task.end).hour.toString().padLeft(2, "0") +
            ":" +
            DateTime.parse(task.end).minute.toString().padLeft(2, "0"),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
    title: Text(
      task.name,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    trailing: Text(task.type));

class AddProgressDialog extends StatefulWidget {
  final String studentId;
  final ScheduleTask task;
  final String today;
  final String duration;

  AddProgressDialog(this.studentId,this.task,this.today,this.duration);
  @override
  _AddProgressDialogState createState() => new _AddProgressDialogState();
}
class _AddProgressDialogState extends State<AddProgressDialog> {

  
  final _formKey = GlobalKey<FormState>();

  var scheduledDuration;
  TextEditingController completeController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 24),
            StudymateTextField("Completed Type",completeController,"text",true,Colors.grey,TextInputType.text,Icon(Icons.lock,color: Colors.grey,)),
            SizedBox(height: 24),
            StudymateTextField("Remarks", remarksController,"" , false, Colors.grey,TextInputType.text, Icon(Icons.lock,color: Colors.grey,)),
          

         

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StudymateRaisedButton("Add Progress", () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  
                  prefix0.ScheduleService().addTaskProgress(widget.studentId, widget.task.name, completeController.text, widget.duration,
                  remarksController.text, widget.today,widget.task.type);
                }
              }, Colors.deepPurple),
            )
          ],
        ),
      ),
    );
  }
}

