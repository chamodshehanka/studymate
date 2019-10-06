import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/custom/StudentService.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class ManageStudentScreen extends StatefulWidget {
  final Student student;

  ManageStudentScreen({Key key, @required this.student});

  @override
  _ManageStudentScreenState createState() => _ManageStudentScreenState();
}

class _ManageStudentScreenState extends State<ManageStudentScreen> {
  final StudentService studentService = StudentService();

  final _formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final schoolName = TextEditingController();
  final birthday = TextEditingController();
  final type = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstName.text = widget.student.firstName;
    lastName.text = widget.student.lastName;
    phoneNumber.text = widget.student.phoneNumber;
    schoolName.text = widget.student.schoolName;
    birthday.text = widget.student.birthday;
    type.text = widget.student.birthday;

  }

  @override
  Widget build(BuildContext context) {
    void studentDeleteAction() {
      Future<dynamic> isDeleted =
          studentService.deleteStudent(widget.student.id);
      if (isDeleted != null) {
        Navigator.pop(context);
      } else {
        print('student Delete Failed');
      }
    }

    void showDeleteConfirmationDialog() {
      if (widget.student.id != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return StudymateDialogBox(
                title: 'Are you sure?',
                description: widget.student.firstName +
                    ' student will be deleted!',
                confirmation: true,
                confirmationAction: studentDeleteAction,
                tigerAnimationType: 'fail',
              );
            });
      } else {
        // showDialog<void>(
        //     context: context, child: Text('Something went wrong'));
      }
    }

    final manageStudentBody = Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: StudymateTextField(
                    'First name',
                    firstName,
                    'text',
                    false,
                    Colors.grey,
                    TextInputType.text,
                    Icon(Icons.person, color: Colors.grey)),
                
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: StudymateTextField(
                    'Phone number',
                    phoneNumber,
                    'text',
                    false,
                    Colors.grey,
                    TextInputType.text,
                    Icon(Icons.phone_android, color: Colors.grey)),
                
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: StudymateTextField(
                    'School name',
                    schoolName,
                    'text',
                    false,
                    Colors.grey,
                    TextInputType.text,
                    Icon(Icons.school, color: Colors.grey)),
                
              ),
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: StudymateTextField(
              //       'Birthday',
              //       birthday,
              //       'text',
              //       false,
              //       Colors.grey,
              //       TextInputType.text,
              //       Icon(Icons.calendar_view_day, color: Colors.grey)),
                
              // ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      child: Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          if (widget.student.id != null) {
                            Student updatedStudent = Student(
                               widget.student.id,
                               firstName.text,
                               lastName.text,
                               email.text,
                               true,
                               phoneNumber.text,
                               schoolName.text,
                               birthday.text,
                               type.text,


                                


                                );

                            Future isUpdated =
                                studentService.updateStudent(updatedStudent);
                            if (isUpdated != null) {
                              Navigator.pop(context);
                            }
                          } else {
                            print('Student id is not valid');
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: Text('Remove'),
                      onPressed: showDeleteConfirmationDialog,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage ' + widget.student.firstName + 'Student'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: manageStudentBody,
      ),
    );
  }
}
