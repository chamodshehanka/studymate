import 'dart:core';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/CloudFunctionsService.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  BaseAuthentication auth = Authentication();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _phoneNumberController =
      new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController badgeNameCtrlController = TextEditingController();
  CloudFunctionService _cloudFunctionService = CloudFunctionService();
  StudymateTextField _nameField;
  CustomTextField _phoneField;
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _nameField = new StudymateTextField(
        'Name',
        _nameController,
        null,
        Colors.grey,
        TextInputType.text,
        Icon(Icons.text_fields, color: Colors.grey));

    // _nameField = new StudymateTextField(
    //   'Name',

    //   //
    //   baseColor: Colors.grey,
    //   borderColor: Colors.grey[400],
    //   errorColor: Colors.red,
    //   controller: _fullname,
    //   hint: "Full Name",
    // );
    _phoneField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _phoneNumberController,
      hint: "Phone Number",
      inputType: TextInputType.number,
    );
    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _emailController,
      hint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _passwordController,
      obscureText: true,
      hint: "Password",
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Text(
                        "Create new account",
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          decoration: TextDecoration.none,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "OpenSans",
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: _nameField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _phoneField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _emailField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _passwordField,
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 40.0),
                      child: CustomFlatButton(
                        title: "Sign Up",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () => {_signUpUser()},
                        splashColor: Colors.black12,
                        borderColor: Colors.blueAccent,
                        borderWidth: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: onBackPress,
                  ),
                ),
              ],
            ),
            Offstage(
              offstage: !_blackVisible,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedOpacity(
                  opacity: _blackVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signUpUser() {
    Future<String> user = _cloudFunctionService.addAdmin(
        _emailController.text, _passwordController.text);

    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();

    //   // Future<String> user =
    //   //     auth.signUp(_emailController.text, _passwordController.text);

    //   if (user != null) {
    //     // Navigator.pushNamed(context, '/home');
    //   } else {
    //     // Have to change
    //     // Navigator.pushNamed(context, '/home');
    //   }
    // }
  }
}

class CustomFlatButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;

  CustomFlatButton(
      {this.title,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.onPressed,
      this.color,
      this.splashColor,
      this.borderColor,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: color,
      splashColor: splashColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            decoration: TextDecoration.none,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "OpenSans",
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final TextInputType inputType;
  final bool obscureText;
  final Function validator;
  final Function onChanged;
  final String labelText;

  CustomTextField(
      {this.hint,
      this.controller,
      this.onChanged,
      this.baseColor,
      this.borderColor,
      this.errorColor,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.labelText,
      this.validator});

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentColor, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          obscureText: widget.obscureText,
          onChanged: (text) {
            if (widget.onChanged != null) {
              widget.onChanged(text);
            }
            setState(() {
              if (!widget.validator(text) || text.length == 0) {
                currentColor = widget.errorColor;
              } else {
                currentColor = widget.baseColor;
              }
            });
          },
          //keyboardType: widget.inputType,
          controller: widget.controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: widget.baseColor,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
            hintText: widget.hint,
          ),
        ),
      ),
    );
  }
}

// https://github.com/AseemWangoo/flutter_programs/blob/master/Cloud%20Firestore.zip

