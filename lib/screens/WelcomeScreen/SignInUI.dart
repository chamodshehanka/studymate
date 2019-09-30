import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateFlatButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class SignInScreen extends StatefulWidget {
  final BaseAuthentication auth;

  const SignInScreen({Key key, this.auth}) : super(key: key);

  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  BaseAuthentication auth = Authentication();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  StudymateTextField _emailField;
  StudymateTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _emailField = StudymateTextField(
        "Email Address",
        emailController,
        "email",
        Colors.grey,
        TextInputType.emailAddress,
        Icon(
          Icons.email,
          color: Colors.grey,
        ));
    _passwordField = StudymateTextField(
        "Password",
        passwordController,
        "password",
        Colors.grey,
        TextInputType.visiblePassword,
        Icon(
          Icons.lock,
          color: Colors.grey,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      "Sign In",
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
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 10.0, left: 15.0, right: 15.0),
                    child: _emailField,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 20.0, left: 15.0, right: 15.0),
                    child: _passwordField,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 40.0),
                    child: StudymateFlatButton(
                      title: "Log In",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.white,
                      onPressed: () {
                        _userLogin();
                      },
                      splashColor: Colors.black12,
                      borderColor: Colors.white,
                      borderWidth: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "OR",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 40.0),
                    child: StudymateFlatButton(
                      title: "Admin Login",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, '/homeAdmin');
                      },
                      splashColor: Colors.black12,
                      borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                      borderWidth: 0,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 40.0),
                    child: StudymateFlatButton(
                      title: "Doctor Login",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, '/homeDoctor');
                      },
                      splashColor: Colors.black12,
                      borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                      borderWidth: 0,
                      color: Color.fromRGBO(59, 89, 152, 1.0),
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
      ),
    );
  }

  Future _userLogin() async {
    //Firebase remote config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(hours: 5));
    await remoteConfig.activateFetched();
    String isAuthEnabled = remoteConfig.getString('auth_enabled');

    //If auth is enabled in remote
    if (_formKey.currentState.validate()) {
      print(isAuthEnabled);
      _formKey.currentState.save();
      if (isAuthEnabled == 'true') {
        Future<FirebaseUser> firebaseUser =
            auth.signIn(emailController.text, passwordController.text);

        firebaseUser.then((user) {
          print('Verified' + user.isEmailVerified.toString());
          // Claim
          user.getIdToken().then((result) {
            // result
            bool isAdmin = result.claims.containsValue('moderator');
            print('Is Admin' + isAdmin.toString());
          });

          if (user.uid.length > 0 && user.uid != null) {
            Navigator.pushNamed(context, '/home');
            print('Sign in okay!');
          } else {
            print("User id is null");

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StudymateDialogBox(
                    title: 'Sign In Failed',
                    description: 'null',
                    confirmation: false,
                    tigerAnimationType: 'fail',
                  );
                });
          }
        });
      } else {
        //If auth is disabled
        Navigator.pushNamed(context, '/home');
      }
    }
  }
}
