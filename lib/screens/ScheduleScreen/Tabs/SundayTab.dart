import 'dart:async';




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/ScheduleTask.dart';
import 'package:studymate/services/custom/ScheduleServices.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';

class SundayTab extends StatefulWidget {
  SundayTab();

  @override
  _SundayTabState createState() => _SundayTabState();
}

class _SundayTabState extends State<SundayTab> {
   ScheduleService scheduleService =  new ScheduleService();
  Future<Calendar> futureCalendar;
  BaseAuthentication baseAuthentication = Authentication();
  StreamSubscription<QuerySnapshot> dailyTaskSubscription;
  Calendar calendar;
  String studentId;
  List<ScheduleTask> sundayTaskList = List();
  @override
  void initState() {
       super.initState();
   baseAuthentication.getCurrentUser().then((user){
        setState(() {
          studentId = user.toString();
        });
         sundayTaskList = List();
      dailyTaskSubscription?.cancel();
      dailyTaskSubscription = scheduleService
          .getDailyTaskList(studentId, 'sunday')
          .listen((QuerySnapshot snapshot) {
       final List<ScheduleTask> tasks = snapshot.documents
          .map((documentSnapshot) => ScheduleTask.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.sundayTaskList = tasks;

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

    Card makeCard(ScheduleTask sundayTask) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(sundayTask),
          ),
        );

    final sundayTabBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: sundayTaskList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(sundayTaskList[index]);
        },
      ),
    );
    return Scaffold(
      body: sundayTabBody,
      backgroundColor: Colors.white10,
      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
         showDialog(
            context: context,
            builder: (_) {
              return AddTaskDialog(studentId: studentId);
            });
        },
      ),
     
    );
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
            DateTime.parse(task.start).hour.toString().padLeft(2,"0")+":"+DateTime.parse(task.start).minute.toString().padLeft(2,"0")+" - "+DateTime.parse(task.end).hour.toString().padLeft(2,"0")+":"+DateTime.parse(task.end).minute.toString().padLeft(2,"0"),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          task.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing:
            Text(task.type)
      );

class AddTaskDialog extends StatefulWidget {
  final String studentId;
  AddTaskDialog({this.studentId});
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

  
  @override
  Widget build(BuildContext context) {

   return AlertDialog(
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(height: 24),
                                      DropdownButtonFormField<String>(
                                        value: type,
                                        hint: Text('Select Type'),
                                        items: ["Study", "Leisure", "Social"]
                                            .map((label) => DropdownMenuItem(
                                                  child: Text(label),
                                                  value: label,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() => type = value);
                                        },
                                      ),
                                      SizedBox(height: 24),
                                      DropdownButtonFormField<String>(
                                        hint: Text('Select Subject/Activity'),
                                        value: activity,
                                        items: ["Science", "Mathematics", "History"]
                                            .map((label) => DropdownMenuItem(
                                                  child: Text(label),
                                                  value: label,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() => activity = value);
                                        },
                                      ),
                                      SizedBox(child: Text("Start Time"),height: 24),
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
                    _startTime = '${time.hour.toString().padLeft(2,"0")}:${time.minute.toString().padLeft(2,"0")}:${time.second.toString().padLeft(2,"0")}';
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
            
                                       SizedBox(child: Text("End Time"),height: 24),
                                


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
                    _endTime = '${time.hour.toString().padLeft(2,"0")}:${time.minute.toString().padLeft(2,"0")}:${time.second.toString().padLeft(2,"0")}';
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
                                        child:StudymateRaisedButton("Add To Schedule",() {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
                                              start = DateTime.parse("2019-01-01 "+_startTime);
                                        end = DateTime.parse("2019-01-01 "+_endTime);
                                          
                                          ScheduleTask scheduleTask = new ScheduleTask(activity, type,start.toString(),end.toString());
                                      
                                          ScheduleService().addToSchedule(widget.studentId, scheduleTask, "sunday");
                                            
                                            }
                                          },Colors.deepPurple),
                                        
                                      )
                                    ],
                                  ),
                                ),
                              );
  }
}
