import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateDropdown.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class TestUIScreen extends StatefulWidget {
  _TestUIScreenState createState() => _TestUIScreenState();
}

class _TestUIScreenState extends State<TestUIScreen> {
  TextEditingController editingController;
  TextInputType textInputType = TextInputType.text;
  Color color = Colors.deepPurple;
  TextStyle textStyle;
  List<String> list = ["Maths", "Science"];

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
              StudymateTextField(
                  "Test", editingController, "Test", color, textInputType),
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
                child: Text('Activity Menu'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                focusColor: Colors.deepPurple,
                onPressed: () =>
                    {Navigator.pushNamed(context, '/activityMenu')},
              ),
              RaisedButton(
                child: Text('Open Dialog Box'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                focusColor: Colors.deepPurple,
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => StudymateDialogBox(
                          title: 'Are you sure?',
                          description: 'Activity will be deleted!',
                          tigerAnimationType: 'fail',
                          confirmation: true,
                          confirmationAction: display,
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
