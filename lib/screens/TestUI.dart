import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateDropdown.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class TestUIScreen extends StatefulWidget {
  _TestUIScreenState createState() => _TestUIScreenState();
}

class _TestUIScreenState extends State<TestUIScreen> {
  TextEditingController editingController;
  TextInputType textInputType = TextInputType.text;
  Color color = Colors.deepPurpleAccent;
  TextStyle textStyle;
  List<String> list = ["Maths", "Science"];
  ActivityService activityService = ActivityService();

  void display() {
    print('Display');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            children: <Widget>[
              StudymateTextField("Test", editingController, "Test", false,
                  color, textInputType, Icon(Icons.email, color: Colors.grey)),
              StudymateDropdown("Select A Subject", list),
              RaisedButton(
                child: Text('Admin Activity'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                focusColor: Colors.deepPurple,
                onPressed: () =>
                    {Navigator.pushNamed(context, '/adminActivity')},
              ),
              RaisedButton(
                child: Text('Doctor Reg'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                focusColor: Colors.deepPurple,
                onPressed: () => {Navigator.pushNamed(context, '/doctorReg')},
              ),
              RaisedButton(
                child: Text('forgot password'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                focusColor: Colors.deepPurple,
                onPressed: () =>
                    {Navigator.pushNamed(context, '/forgotPassword')},
              ),
              RaisedButton(
                child: Text('Doctor Reg'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                focusColor: Colors.deepPurple,
                onPressed: () => {Navigator.pushNamed(context, '/studentAdd')},
              ),
              RaisedButton(
                child: Text('Doctor Reg'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                focusColor: Colors.deepPurple,
                onPressed: () =>
                    {Navigator.pushNamed(context, '/SchoolStudentEditPage')},
              ),
              RaisedButton(
                  child: Text('Admin Activity Dashboard'),
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  focusColor: Colors.deepPurple,
                  onPressed: () {
                    Navigator.pushNamed(context, '/adminActivityDashboard');
                  }),
              StudymateRaisedButton("Sign Up",
                  () => {Navigator.pushNamed(context, '/signUp')}, color),
              StudymateRaisedButton(
                  "Delete",
                  () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                StudymateDialogBox(
                                  title: 'Are you sure?',
                                  description: 'Activity will be deleted!',
                                  tigerAnimationType: 'fail',
                                  confirmation: true,
                                  confirmationAction: display,
                                )),
                      },
                  Colors.red)
            ],
          ),
        ),
      ),
    );
  }
}
