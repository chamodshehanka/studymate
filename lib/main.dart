import 'package:flutter/material.dart';
import 'package:studymate/screens/SplashScreen.dart';
import 'package:studymate/screens/daily.dart';
import 'package:studymate/screens/first.dart';
import 'package:studymate/screens/home.dart';
import 'package:studymate/screens/signin.dart';
import 'package:studymate/screens/signup.dart';

var routes = <String, WidgetBuilder>{
  '/first': (context) => WelcomeScreen(),
  '/signin': (context) => SignInScreen(),
  '/signup': (context) => SignUpScreen(),
  '/home': (context) => HomeScreen(),
  '/daily': (context) => DailyScreen()
};

void main() {
  var materialApp = MaterialApp(
      title: 'StudyMate',
      theme: ThemeData(
          primaryColor: new Color(0xff622F74), accentColor: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: routes);
  return runApp(materialApp);
}
