//import 'package:flushbar/flushbar.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/custom/StudentService.dart';
//import 'package:googleapis/servicecontrol/v1.dart';
//import 'package:studymate/auth.dart';
//import 'package:studymate/models/Student.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

import 'package:studymate/widgets/loading.dart';

class SchoolStudentAddDetailsScreen extends StatefulWidget {
  _SchoolStudentAddDetailsScreenState createState() =>
      _SchoolStudentAddDetailsScreenState();
//   final String labelText;
//   SchoolStudentAddDetailsScreen(this.labelText);
// @override
// State<StatefulWidget> createState() {
//     return _SchoolStudentAddDetailsScreenState(labelText);
//   }

}

class _SchoolStudentAddDetailsScreenState
    extends State<SchoolStudentAddDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _birthday = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  final TextEditingController _schoolName = new TextEditingController();
  var type;

  List<Student> studentList;
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> studentSubscription;
  List<String> genderTypeList;
  //List<String> studentList;

  String mascotAnimationType;

// String labelText;
//   _SchoolStudentAddDetailsScreenState(this.labelText);
//   DateTime _date = DateTime.now();
//   TimeOfDay _time = new TimeOfDay.now();

//   var dateController = TextEditingController();

// Future<void> _selectDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2019),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _date) {
//       setState(() {
//         _date = picked;
//         dateController.text = _date.year.toString() +
//             ' - ' +
//             _date.month.toString() +
//             ' - ' +
//             _date.day.toString();
//       });
//     }
//   }

  int groupValue;
  bool b = true;
  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
    groupValue = 0;
    studentList = List();
    studentSubscription?.cancel();
    studentSubscription =
        studentService.getStudentList().listen((QuerySnapshot snapshot) {
      final List<Student> students = snapshot.documents
          .map((documentSnapshot) => Student.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.studentList = students;
      });
    });
  }

  @override
  void dispose() {
    studentSubscription?.cancel();
    super.dispose();
  }

  setSelectedRadio(int val) {
    setState(() {
      groupValue = val;
      if (val == 0) {
        b = true;
      } else if (val == 1) {
        b = false;
      }
    });
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default.png',
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );

    final firstName = StudymateTextField(
        "First Name",
        _firstName,
        "name",
        false,
        Colors.grey,
        TextInputType.text,
        Icon(
          Icons.person,
          color: Colors.grey,
        ));

    final lastName = StudymateTextField(
        "Last Name",
        _lastName,
        "name",
        false,
        Colors.grey,
        TextInputType.text,
        Icon(
          Icons.person,
          color: Colors.grey,
        ));

    final birthday = StudymateTextField(
        "Birthday",
        _birthday,
        "birthday",
        false,
        Colors.grey,
        TextInputType.text,
        Icon(
          Icons.calendar_view_day,
          color: Colors.grey,
        ));

    final phoneNumber = StudymateTextField(
        "Phone Number",
        _phoneNumber,
        "phone",
        false,
        Colors.grey,
        TextInputType.text,
        Icon(
          Icons.phone_android,
          color: Colors.grey,
        ));

    final schoolName = StudymateTextField(
        "School Name",
        _schoolName,
        "school",
        false,
        Colors.grey,
        TextInputType.text,
        Icon(
          Icons.school,
          color: Colors.grey,
        ));

    final signUpButton = StudymateRaisedButton(
        "Sign Up",
        () => {
              _addStudentDetails(
                  firstName: _firstName.text,
                  lastName: _lastName.text,
                  birthday: _birthday.text,
                  phoneNumber: _phoneNumber.text,
                  schoolName: _schoolName.text,
                  type: type,
                  context: context)
            },
        Colors.deepPurple);

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      SizedBox(height: 48.0),
                      firstName,
                      SizedBox(height: 24.0),
                      lastName,
                      SizedBox(height: 24.0),
                      birthday,
                      SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Icon(Icons.person, color: Colors.grey),
                              )),
                          value: type,
                          hint: Text('Gender'),
                          items: ["Male", "Female"]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: label,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => type = value);
                          },
                        ),
                      ),
                      SizedBox(height: 24.0),
                      phoneNumber,
                      SizedBox(height: 24.0),
                      schoolName,
                      SizedBox(height: 24.0),
                      signUpButton,
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _addStudentDetails(
      {String firstName,
      String lastName,
      String birthday,
      bool schooling,
      String phoneNumber,
      String schoolName,
      String type,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();

        await Navigator.pushNamed(context, '/home');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
        String exception = Authentication.getExceptionText(e);
        Flushbar(
          title: "Sign Up Error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
