import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';
import 'package:studymate/widgets/loading.dart';

class StudentAddScreen extends StatefulWidget {
  _StudentAddScreenState createState() => _StudentAddScreenState();
}

class _StudentAddScreenState extends State<StudentAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _confirmPassword = new TextEditingController();
  bool _autoValidate = false;
  bool _loadingVisible = false;
  BaseAuthentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final email = StudymateTextField(
        labelText: "Email",
        textEditingController: _email,
        validation: "email",
        keyboardType: TextInputType.emailAddress,
        icon: Icon(
          Icons.email,
          color: Colors.grey,
        ));

    final password = StudymateTextField(
        labelText: "Password",
        textEditingController: _password,
        validation: "password",
        obscureText: true,
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
        ));

    final confirmPassword = StudymateTextField(
        labelText: "Confirm password",
        textEditingController: _confirmPassword,
        validation: "confirmPassword",
        obscureText: true,
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
        ));

    final signUpButton = StudymateRaisedButton(
        "Create Student Account",
        () => {
              _emailSignUp(
                  email: _email.text,
                  password: _password.text,
                  confirmPassword: _confirmPassword.text,
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
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      email,
                      SizedBox(height: 24.0),
                      password,
                      SizedBox(height: 12.0),
                      confirmPassword,
                      SizedBox(height: 12.0),
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
      {String email,
      String password,
      String confirmPassword,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();

        Student student =
            Student('id', null, null, email, null, null, null, null, null);

        _authentication.signUp(email, password, 'student', student);
        await Navigator.pushNamed(context, '/homeAdmin');
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
