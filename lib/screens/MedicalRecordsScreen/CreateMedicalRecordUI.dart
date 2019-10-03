import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class CreateMedicalRecordScreen extends StatefulWidget {
  _CreateMedicalRecordScreenState createState() =>
      _CreateMedicalRecordScreenState();
}

class _CreateMedicalRecordScreenState extends State<CreateMedicalRecordScreen> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _recordDetailsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var createMedicalRecordBody = Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SafeArea(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Container(
                    width: 255,
                    child: StudymateTextField(
                        'Student Name',
                        _studentNameController,
                        'text',
                        false,
                        Colors.grey,
                        TextInputType.text,
                        Icon(Icons.search, color: Colors.grey)),
                  ),
                ),
                Container(
                  width: 150,
                  child: StudymateRaisedButton(
                      'Search', searchStudent, Colors.deepPurpleAccent),
                ),
              ],
            ),
          ),
          StudymateTextField('Record Details', _recordDetailsController, 'text',
              false, Colors.grey, TextInputType.text, Icon(Icons.comment)),
          Container(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 150,
                child: StudymateRaisedButton(
                    'Create', createMedicalRecord, Colors.deepPurpleAccent),
              ),
              Container(
                width: 150,
                child: StudymateRaisedButton(
                    'Cancel', closeWindow, Colors.redAccent),
              )
            ],
          )
        ],
      ),
    );

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Create Medical Record'),
              backgroundColor: Colors.deepPurple,
            ),
            body: createMedicalRecordBody));
  }

  void searchStudent() {
    print('Search student' + _studentNameController.text);
    var date = new DateTime.now();
    log(date.toString());
  }

  void closeWindow() {
    Navigator.pop(context);
  }

  void createMedicalRecord() {}
}
