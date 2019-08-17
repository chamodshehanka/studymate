import 'package:flutter/material.dart';
import 'package:studymate/routes_generator.dart';

void main() {
  var materialApp = MaterialApp(
    title: 'Study Mate',
    theme: ThemeData(
        primaryColor: new Color(0xff622F74), accentColor: Colors.deepPurple),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
  );
  return runApp(materialApp);
}
