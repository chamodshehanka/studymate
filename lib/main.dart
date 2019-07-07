import 'package:flutter/material.dart';
import 'package:studymate/SplashScreen.dart';
import 'package:studymate/first.dart';
import 'package:studymate/signin.dart';
import 'package:studymate/signup.dart';

var routes=<String,WidgetBuilder>{
  '/first':(context) => WelcomeScreen(),
  '/signin':(context) => SignInScreen(),
  '/signup' : (context) => SignUpScreen(),
};

void main() {
  var materialApp = MaterialApp(
    title: 'StudyMate',
        theme: ThemeData(
         primaryColor: new Color(0xff622F74),
          accentColor: Colors.orange
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: routes
  
  );
    return runApp(materialApp);
}

