
import 'dart:core';

import "package:flutter/material.dart";


void main() => runApp(new MaterialApp(
  title: 'Registration Form',
  home: new SchoolStudentScreen(),
));

class SchoolStudentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SchoolStudentScreenState();
}

class RegistrationData {
  String userName = '';
  String email = '';
  String password = '';
  String schoolName = '';
  String phoneNumber = '';
}

class SchoolStudentScreenState extends State<SchoolStudentScreen> {
    final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
    RegistrationData data = new RegistrationData();

     String validateName (String value) {
    String pattern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is Required";
    }else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

     String validateEmail (String value) {
    Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    }
    else if (!regex.hasMatch(value))
      return 'Invalid Email';
    else{
      return null;
    }
  }
    String validatePassword (String value) {
    if (value.length > 6){
    return 'Password must be more than 6 character';
    }else{
    return null;
    }
  }
    String validateSchoolName(String value) {
      if(value.length < 6) {
        return 'The Password must be at least 6 characters';
      }
      return null;
    }

    String validateMobile (String value) {
   String pattern = r'(^[0-9]*$)';
   RegExp regExp = new RegExp(pattern);
   if (value.length == 0) {
     return "Mobile is Required";
   }else if(value.length != 10) {
     return "Mobile number must 10 digits";
  }else if (!regExp.hasMatch(value)) {
    return "Mobile Number must be digits";
  }
  return null;
  }

    void submit() {
      if(this.formKey.currentState.validate()) {
        formKey.currentState.save();

        print('Printing the registration data');
        print('User Name: ${data.userName}');
        print('Email: ${data.email}');
        print('Password: ${data.password}');
        print('User Name: ${data.schoolName}');
        print('User Name: ${data.phoneNumber}');
      }
    }

    @override
    Widget build(BuildContext context) {
      final Size screenSize = MediaQuery.of(context).size;

      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Register')
        ),
        body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this.formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                    hintText: 'you@example.com',
                    labelText: 'E-mail Address'
                  ),
                  validator: this.validateEmail,
                  onSaved: (String value) {
                    this.data.email = value;
                  },
                ),
                new TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                    hintText: 'Password',
                    labelText: 'Enter the password'

                  ),
                  validator: this.validatePassword,
                  onSaved: (String value) {
                    this.data.password = value;
                 }
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Register',
                      style: new TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: this.submit,
                    color: Colors.purple,
                  ),
                  margin: new EdgeInsets.only(
                    top: 20.0
                  ),
                )
              ],
            ),
          )
        ),
      );
      
    }


}
