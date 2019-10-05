    
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/models/settings.dart';

class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  Student student;
  Settings settings;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.student,
    this.settings,
  });
}