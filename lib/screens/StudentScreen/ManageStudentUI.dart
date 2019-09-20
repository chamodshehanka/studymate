import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/custom/StudentService.dart';


/*class ManageStudentScreen extends StatelessWidget {
  final Student student;
  final StudentService studentService =  StudentService();

  ManageStudentScreen({Key key, @required this.student});



  @override
  Widget build(BuildContext context) {
    final manageStudentBody = Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: student.id,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: student.name,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: student.phone.toString(),
            ),
           ),
             Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: student.email,
            ),
          ),
           Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: student.password,
            ),
          ),
           
        
        
          
         
         
           
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.deepPurpleAccent,
              child: Text('Save'),
              onPressed: () {
                if (student.id!= null) {
                  Future isUpdated = studentService.updateStudent(student);
                  if (isUpdated != null) {
                    Navigator.pop(context);
                  }
                } else {}
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.redAccent,
              child: Text('Remove'),
              onPressed: () {
                if (student.name != null) {
                  showDialog<ConfirmAction>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Are you sure?'),
                          actions: <Widget>[
                            RaisedButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(ConfirmAction.CANCEL);
                                }),
                            RaisedButton(
                                child: Text('Accept'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(ConfirmAction.ACCEPT);
                                  Future<dynamic> isDeleted = studentService
                                      .deletestudent(student.id);
                                  if (isDeleted != null) {
                                    Navigator.pop(context);
                                    Scaffold.of(context)
                                        .showSnackBar(new SnackBar(
                                      content: new Text("Successfully Deleted!"),
                                      backgroundColor: Colors.deepPurple,
                                    ));
                                  } else {}
                                }),
                          ],
                        );
                      });
                } else {
                  
                }
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: manageStudentBody,
    );
  }

  @override
  State<StatefulWidget> createState() {

    return null;
  }
}

enum ConfirmAction { CANCEL, ACCEPT }
*/
class ManageStudentScreen extends StatelessWidget {
  final Student student;
  final StudentService studentService = StudentService();

  ManageStudentScreen({Key key, @required this.student});

  @override
  Widget build(BuildContext context) {
    final manageStudentBody = Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: student.name,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: student.id,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.deepPurpleAccent,
              child: Text('Save'),
              onPressed: () {
                if (student.id != null) {
                  Future isUpdated = studentService.updateStudent(student);
                  if (isUpdated != null) {
                    Navigator.pop(context);
                  }
                } else {}
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.redAccent,
              child: Text('Remove'),
              onPressed: () {
                if (student.id != null) {
                  showDialog<ConfirmAction>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Are you sure?'),
                          actions: <Widget>[
                            RaisedButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(ConfirmAction.CANCEL);
                                }),
                            RaisedButton(
                                child: Text('Accept'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(ConfirmAction.ACCEPT);
                                  Future<dynamic> isDeleted = studentService
                                      .deleteStudent(student.id);
                                  if (isDeleted != null) {
                                    Navigator.pop(context);
                                    Scaffold.of(context)
                                        .showSnackBar(new SnackBar(
                                      content: new Text("Successfully Deleted!"),
                                      backgroundColor: Colors.deepPurple,
                                    ));
                                  } else {}
                                }),
                          ],
                        );
                      });
                } else {
                  // showDialog<void>(
                  //     context: context, child: Text('Something went wrong'));
                }
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: manageStudentBody,
      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Text(activity.type),
      // ),
    );
  }
}

enum ConfirmAction { CANCEL, ACCEPT }
