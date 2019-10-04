//new task.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'createtodo.dart';

class EditAppointment extends StatefulWidget {
  EditAppointment({this.taskappointmentID,this.taskSpecialDescription,this.taskDate,this.taskTime,this.taskplace});
  final String taskappointmentID;
  final String taskSpecialDescription;
  final String taskDate;
  final String taskTime;
  final String taskplace;
  @override
  _EditAppointmentState createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {
  String taskappointmentID,
      taskname,
      taskSpecialDescription,
      taskDate,
      taskTime,
      taskplace;

  getTaskappointmentID(taskappointmentID) {
    this.taskappointmentID = taskappointmentID;
  }

  getTaskName(taskname) {
    this.taskname = taskname;
  }

  getTaskSpecialDescription(taskSpecialDescription) {
    this.taskSpecialDescription = taskSpecialDescription;
  }

  getTaskDate(taskDate) {
    this.taskDate = taskDate;
  }

  getTaskTime(taskTime) {
    this.taskTime = taskTime;
  }

  gettaskplace(taskplace) {
    this.taskplace = taskplace;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _myAppBar(),
          Container(
            alignment: FractionalOffset.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: ListView(
              children: <Widget>[
                
                Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 14.0),
                  child: TextField(
                    // controller: _taskNameController,
                    onChanged: (String taskappointmentID) {
                      getTaskappointmentID(taskappointmentID);
                    },
                    decoration: InputDecoration(labelText: "Appointment ID "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 14.0),
                  child: TextField(
                    // controller: _taskNameController,
                    onChanged: (String taskname) {
                      getTaskName(taskname);
                    },
                    decoration: InputDecoration(labelText: "Patient Name "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17.0, right: 17.0),
                  child: TextField(
                    //controller: _taskDetailsController,
                    decoration:
                        InputDecoration(labelText: "Special Description: "),
                    onChanged: (String taskSpecialDescription) {
                      getTaskSpecialDescription(taskSpecialDescription);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 14.0),
                  child: TextField(
                    // controller: _taskDateController,
                    decoration: InputDecoration(labelText: "Date: "),
                    onChanged: (String taskdate) {
                      getTaskDate(taskdate);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 14.0),
                  child: TextField(
                    // controller: _taskTimeController,
                    decoration: InputDecoration(labelText: "Time: "),
                    onChanged: (String tasktime) {
                      getTaskTime(tasktime);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 14.0),
                  child: TextField(
                    //controller: _taskTimeController,
                    decoration: InputDecoration(labelText: "Place "),
                    onChanged: (String taskplace) {
                      gettaskplace(taskplace);
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                    // This button results in adding the contact to the database
                    RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          EditAppointment();
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _myAppBar() {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF6A1B9A),
              const Color(0xFF6A1B9A),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 0.0),
            stops: [0.0, 0.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Edit Appointments',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
