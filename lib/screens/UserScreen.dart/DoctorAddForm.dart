import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';
import 'package:studymate/widgets/loading.dart';

class DoctorAddScreen extends StatefulWidget {
  _DoctorAddScreenState createState() => _DoctorAddScreenState();
}

class _DoctorAddScreenState extends State<DoctorAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _nicNumber = new TextEditingController();
  final TextEditingController _slmcRegNumber = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  final TextEditingController _workingPlace = new TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  BaseAuthentication _authentication = Authentication();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
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

    final nicNumber = StudymateTextField(
        labelText: "NIC number",
        textEditingController: _nicNumber,
        validation: "NIC number",
        icon: Icon(
          Icons.credit_card,
          color: Colors.grey,
        ));

    final slmcRegNumber = StudymateTextField(
        labelText: "SLMC reg number",
        textEditingController: _slmcRegNumber,
        validation: "SLMC reg number",
        icon: Icon(
          Icons.credit_card,
          color: Colors.grey,
        ));

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
        labelText: 'Password',
        textEditingController: _password,
        validation: 'password',
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
        ));

    final confirmPassword = StudymateTextField(
        labelText: 'Confirm password',
        textEditingController: _confirmPassword,
        validation: 'password',
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
        ));

    final phoneNumber = StudymateTextField(
        labelText: "Phone Number",
        textEditingController: _phoneNumber,
        validation: "phone number",
        icon: Icon(
          Icons.phone,
          color: Colors.grey,
        ));

    final workingPlace = StudymateTextField(
        labelText: "Working palce",
        textEditingController: _workingPlace,
        validation: "working place",
        icon: Icon(
          Icons.place,
          color: Colors.grey,
        ));

    final signUpButton = StudymateRaisedButton(
        "Create Account",
        () => {
              _addDoctorDetails(
                  firstName: _firstName.text,
                  lastName: _lastName.text,
                  nicNumber: _nicNumber.text,
                  slmcRegNumber: _slmcRegNumber.text,
                  email: _email.text,
                  password: _password.text,
                  confirmPassword: _confirmPassword.text,
                  phoneNumber: _phoneNumber.text,
                  workingPlace: _workingPlace.text,
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
                      firstName,
                      SizedBox(height: 1.0),
                      lastName,
                      SizedBox(height: 1.0),
                      nicNumber,
                      SizedBox(
                        height: 1.0,
                      ),
                      slmcRegNumber,
                      SizedBox(
                        height: 1.0,
                      ),
                      email,
                      SizedBox(height: 1.0),
                      password,
                      SizedBox(height: 1.0),
                      confirmPassword,
                      SizedBox(height: 1.0),
                      phoneNumber,
                      SizedBox(height: 1.0),
                      workingPlace,
                      SizedBox(height: 1.0),
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

  void _addDoctorDetails(
      {String firstName,
      String lastName,
      String nicNumber,
      String slmcRegNumber,
      String email,
      String password,
      String confirmPassword,
      String phoneNumber,
      String workingPlace,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();

        Doctor doctor = Doctor(
            'id', firstName, lastName, slmcRegNumber, nicNumber, workingPlace);

        _authentication.signUp(email, password, 'doctor', doctor);
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
