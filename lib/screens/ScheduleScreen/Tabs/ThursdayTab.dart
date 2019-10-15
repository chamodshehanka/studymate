import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/models/Calendar.dart';
import 'package:studymate/models/ScheduleTask.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:studymate/services/custom/StudentService.dart';
import 'package:studymate/utils/CommonConstants.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';

class ThursdayTab extends StatefulWidget {
  ThursdayTab();

  @override
  _ThursdayTabState createState() => _ThursdayTabState();
}

class _ThursdayTabState extends State<ThursdayTab> {
  ScheduleService scheduleService = new ScheduleService();
  StudentService studentService = new StudentService();
  Future<Calendar> futureCalendar;
  BaseAuthentication baseAuthentication = Authentication();
  StreamSubscription<QuerySnapshot> dailyTaskSubscription;
  StreamSubscription<QuerySnapshot> socialActivitySubscription;
  StreamSubscription<QuerySnapshot> leisureActivitySubscription;
  Calendar calendar;
  String studentId;
  List socialActivities = List();
  List leisureActivities = List();
  List<ScheduleTask> thursdayTaskList = List();
  @override
  void initState() {
    super.initState();
    baseAuthentication.getCurrentUser().then((user) {
      setState(() {
        studentId = user.toString();
      });
      thursdayTaskList = List();
      dailyTaskSubscription?.cancel();
      dailyTaskSubscription = scheduleService
          .getDailyTaskList(studentId, 'thursday')
          .listen((QuerySnapshot snapshot) {
        final List<ScheduleTask> tasks = snapshot.documents
            .map((documentSnapshot) =>
                ScheduleTask.fromMap(documentSnapshot.data))
            .toList();
        setState(() {
          this.thursdayTaskList = tasks;
        });
      });
      socialActivitySubscription?.cancel();
      socialActivitySubscription = studentService.getAllPreferredActivities
      (studentId, "Social")
          .listen((QuerySnapshot snapshot) {
        final List activities = snapshot.documents
            .map((documentSnapshot) =>
                Activity.fromMap(documentSnapshot.data).name)
            .toList();
      
        setState(() {
          this.socialActivities = activities;
        });
      });

      leisureActivitySubscription?.cancel();
      leisureActivitySubscription = studentService.getAllPreferredActivities
      (studentId, "Leisure")
          .listen((QuerySnapshot snapshot) {
        final List activities = snapshot.documents
            .map((documentSnapshot) =>
                Activity.fromMap(documentSnapshot.data).name)
            .toList();
      
        setState(() {
          this.leisureActivities = activities;
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
     Card makeCard(ScheduleTask thursdayTask) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Slidable(child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(thursdayTask),
          ),
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
            IconSlideAction(caption: 'Delete',
            color: Colors.redAccent,
            icon: Icons.delete,
            onTap: ()=> deleteTask(thursdayTask),),
            IconSlideAction(caption: 'Update',
            color: Colors.yellowAccent,
            icon: Icons.update,
            onTap: ()=> updateTask(thursdayTask,socialActivities,leisureActivities),)
          ],)
         
        );

    final thursdayTabBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: thursdayTaskList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(thursdayTaskList[index]);
        },
      ),
    );
    return Scaffold(
      body: thursdayTabBody,
      backgroundColor: Colors.white10,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AddTaskDialog(studentId,this.socialActivities,this.leisureActivities);
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

 void deleteTask(ScheduleTask task) {
      baseAuthentication.getCurrentUser().then((user) {
      studentId = user;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return StudymateDialogBox(
                title: 'Are you sure?',
                description: task.name +
                    ' Task will be permanently deleted!',
                confirmation: true,
                confirmationAction: (){
      Future<dynamic> isDeleted =
          scheduleService.deleteTask(studentId, "thursday", task.id.toString());
      isDeleted.then((result) {
        if (result) {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text('Successfully Removed'),
            backgroundColor: Colors.green,
          ));
        } else {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text('Adding failed!'),
            backgroundColor: Colors.redAccent,
          ));

        }
      }
      );
      Navigator.pop(context);
    },
                tigerAnimationType: 'fail',
              );
            });}
    );
  }
     void updateTask(ScheduleTask task,List socialList,List leisureList) {
    
        String start = '${DateTime.parse(task.start).hour.toString().padLeft(2, "0")}:${DateTime.parse(task.start).minute.toString().padLeft(2, "0")}:${DateTime.parse(task.start).second.toString().padLeft(2, "0")}';
        String end = '${DateTime.parse(task.end).hour.toString().padLeft(2, "0")}:${DateTime.parse(task.end).minute.toString().padLeft(2, "0")}:${DateTime.parse(task.end).second.toString().padLeft(2, "0")}';

  
         showDialog(
              context: context,
              builder: (_) {
                return UpdateTaskDialog(studentId, task,start,end,socialList,leisureList);
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

class AddTaskDialog extends StatefulWidget {
  final String studentId;
    final List socialList;
  final List  leisureList;
  AddTaskDialog(this.studentId,this.socialList,this.leisureList);
  @override
  _AddTaskDialogState createState() => new _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String _startTime = "Not set";
  String _endTime = "Not set";
  DateTime start;
  DateTime end;
  final _formKey = GlobalKey<FormState>();
  var type;
  var activity;
  var taskList = List();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 24),
            DropdownButtonFormField(
              value: type,
              hint: Text('Select Type'),
              items: CommonConstants.scheduleTypes
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => type = value);
                setState(() {
                  switch(type){
                    case "Social" : taskList = widget.socialList;
                      break;
                    case "Leisure" : taskList = widget.leisureList;
                      break;
                    default : taskList = ["Select Type First"];
                  }
                });
              },
            ),
            SizedBox(height: 24),
            DropdownButtonFormField(
              hint: Text('Select Task'),
              value: activity,
              items:taskList
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => activity = value);
              },
            ),
            SizedBox(child: Text("Start Time"), height: 24),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showTimePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true, onConfirm: (time) {
                  print('confirm $time');
                  _startTime =
                      '${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}:${time.second.toString().padLeft(2, "0")}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                              Text(
                                " $_startTime",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            SizedBox(child: Text("End Time"), height: 24),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showTimePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true, onConfirm: (time) {
                  print('confirm $time');
                  _endTime =
                      '${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}:${time.second.toString().padLeft(2, "0")}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                              Text(
                                " $_endTime",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StudymateRaisedButton("Add To Schedule", () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  start = DateTime.parse("2019-01-01 " + _startTime);
                  end = DateTime.parse("2019-01-01 " + _endTime);

                  ScheduleTask scheduleTask = new ScheduleTask(
                      activity, type, start.toString(), end.toString());

                  ScheduleService()
                      .addToSchedule(widget.studentId, scheduleTask, "thursday");
                      Navigator.pop(context);
                }
              }, Colors.deepPurple),
            )
          ],
        ),
      ),
    );
  }
}


class UpdateTaskDialog extends StatefulWidget {
 
  final String studentId;
  final ScheduleTask task;
  final String start;
  final String end;
  final List socialList;
  final List leisureList;


  UpdateTaskDialog(this.studentId,this.task,this.start,this.end,this.socialList,this.leisureList);
  @override
  _UpdateTaskDialogState createState() => new _UpdateTaskDialogState(task.id,task.name,task.type,start,end);
}

class _UpdateTaskDialogState extends State<UpdateTaskDialog> {


  String id;
  String name;
  String type;
  DateTime start;
  DateTime end;
  String _startTime;
  String _endTime;
  var taskList = List();

  _UpdateTaskDialogState(this.id,this.name,this.type,this._startTime,this._endTime);



  
    
    final _formKey = GlobalKey<FormState>();
    
    

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 24),
              DropdownButtonFormField(
                value: type,

                hint: Text('Select Type'),
                items: CommonConstants.scheduleTypes
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => type = value);
                  setState(() {
                  switch(type){
                    case "Social" : taskList = widget.socialList;
                      break;
                    case "Leisure" : taskList = widget.leisureList;
                      break;
                    default : taskList = ["Select Type First"];
                  }
                    });
                },
              ),
              SizedBox(height: 24),
              DropdownButtonFormField(
                hint: Text('Select Task'),
                value: name,
                items: taskList
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label),
                                          value: label,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() => name = value);
                                },
                              ),
                              SizedBox(child: Text("Start Time"), height: 24),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                elevation: 4.0,
                                onPressed: () {
                                  DatePicker.showTimePicker(context,
                                      theme: DatePickerTheme(
                                        containerHeight: 210.0,
                                      ),
                                      showTitleActions: true, onConfirm: (time) {
                                    print('confirm $time');
                                    _startTime =
                                        '${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}:${time.second.toString().padLeft(2, "0")}';
                                    setState(() {});
                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  size: 18.0,
                                                  color: Colors.teal,
                                                ),
                                                Text(
                                                  " $_startTime",
                                                  style: TextStyle(
                                                      color: Colors.teal,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "  Change",
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              SizedBox(child: Text("End Time"), height: 24),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                elevation: 4.0,
                                onPressed: () {
                                  DatePicker.showTimePicker(context,
                                      theme: DatePickerTheme(
                                        containerHeight: 210.0,
                                      ),
                                      showTitleActions: true, onConfirm: (time) {
                                    print('confirm $time');
                                    _endTime =
                                        '${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}:${time.second.toString().padLeft(2, "0")}';
                                    setState(() {});
                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.access_time,
                                                  size: 18.0,
                                                  color: Colors.teal,
                                                ),
                                                Text(
                                                  " $_endTime",
                                                  style: TextStyle(
                                                      color: Colors.teal,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "  Change",
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StudymateRaisedButton("Update Task", () {
                                  if (_formKey.currentState.validate()) {
                                     _formKey.currentState.save();
                                    start = DateTime.parse("2019-01-01 " + _startTime);
                                    end = DateTime.parse("2019-01-01 " + _endTime);
                  
                                    ScheduleTask scheduleTask = new ScheduleTask(
                                         name, type, start.toString(), end.toString());
                                         scheduleTask.setId(id);
                  
                                     ScheduleService()
                                        .updateTask(widget.studentId, scheduleTask, "thursday");
                                        Navigator.pop(context);
                                  }
                                }, Colors.deepPurple),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                
  
    
}