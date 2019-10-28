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

class NonSchoolStudentAddDetailsScreen extends StatefulWidget {
  _NonSchoolStudentAddDetailsScreenState createState() =>
      _NonSchoolStudentAddDetailsScreenState();
}

class _NonSchoolStudentAddDetailsScreenState
    extends State<NonSchoolStudentAddDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _birthday = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  var type;
  List<Student> studentList;
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> studentSubscription;
  List<String> genderTypeList;
  //List<String> studentList;

  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();

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

    genderTypeList = ['Male', 'Female'];
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
        labelText: "First Name",
        textEditingController: _firstName,
        validation: "name",
        icon: Icon(
          Icons.person,
          color: Colors.grey,
        ));

    final lastName = StudymateTextField(
        labelText: "Last Name",
        textEditingController: _lastName,
        validation: "name",
        icon: Icon(
          Icons.person,
          color: Colors.grey,
        ));

    final birthday = StudymateTextField(
        labelText: "Birthday (dd/mm/yyyy)",
        textEditingController: _birthday,
        validation: "name",
        icon: Icon(
          Icons.calendar_view_day,
          color: Colors.grey,
        ));

    final phoneNumber = StudymateTextField(
        labelText: "Phone Number",
        textEditingController: _phoneNumber,
        validation: "phone",
        icon: Icon(
          Icons.phone_android,
          color: Colors.grey,
        ));

    final signUpButton = StudymateRaisedButton(
        "Sign Up",
        () => {
              _emailSignUp(
                  firstName: _firstName.text,
                  lastName: _lastName.text,
                  birthday: _birthday.text,
                  phoneNumber: _phoneNumber.text,
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

  void _emailSignUp(
      {String firstName,
      String lastName,
      String birthday,
      String phoneNumber,
      var type,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();

        // await Auth.signUp(email, password).then((uID) {
        //   Auth.addUserSettingsDB(new User(
        //     userId: uID,
        //     email: email,
        //     firstName: firstName,
        //     lastName: lastName,
        //   ));
        // });

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
