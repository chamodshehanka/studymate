// import 'dart:async';
// //import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:studymate/models/Student.dart';
// import 'package:studymate/models/settings.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

// class Auth {
//   static Future<String> signUp(String email, String password) async {
//     FirebaseUser user = (await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password)) as FirebaseUser;
//     return user.uid;
//   }

//   static void studentAddDetailsDB(Student student) async {
//     checkUserExist(student.id).then((value) {
//       if (!value) {
//         print("student ${student.firstName} ${student.email} added");
//         Firestore.instance
//             .document("student/${student.id}")
//             .setData(student.toMap());
//         _addSettings(new Settings(
//           settingsId: student.id,
//         ));
//       } else {
//         print("student ${student.firstName} ${student.email} exists");
//       }
//     });
//   }

//   static Future<bool> checkUserExist(String userId) async {
//     bool exists = false;
//     try {
//       await Firestore.instance.document("student/$userId").get().then((doc) {
//         if (doc.exists)
//           exists = true;
//         else
//           exists = false;
//       });
//       return exists;
//     } catch (e) {
//       return false;
//     }
//   }

//   static void _addSettings(Settings settings) async {
//     Firestore.instance
//         .document("settings/${settings.settingsId}")
//         .setData(settings.toJson());
//   }

//   static Future<String> signIn(String email, String password) async {
//     FirebaseUser user = (await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password)) as FirebaseUser;
//     return user.uid;
//   }

//   static Future<User> getUserFirestore(String userId) async {
//     if (userId != null) {
//       return Firestore.instance
//           .collection('users')
//           .document(userId)
//           .get()
//           .then((documentSnapshot) => User.fromDocument(documentSnapshot));
//     } else {
//       print('firestore userId can not be null');
//       return null;
//     }
//   }

//   static Future<Settings> getSettingsFirestore(String settingsId) async {
//     if (settingsId != null) {
//       return Firestore.instance
//           .collection('settings')
//           .document(settingsId)
//           .get()
//           .then((documentSnapshot) => Settings.fromDocument(documentSnapshot));
//     } else {
//       print('no firestore settings available');
//       return null;
//     }
//   }

//   static Future<String> storeUserLocal(Student student) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String storeUser = userToJson(user);
//     await prefs.setString('user', storeUser);
//     return user.userId;
//   }

//   static Future<String> storeSettingsLocal(Settings settings) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String storeSettings = settingsToJson(settings);
//     await prefs.setString('settings', storeSettings);
//     return settings.settingsId;
//   }

//   static Future<FirebaseUser> getCurrentFirebaseUser() async {
//     FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
//     return currentUser;
//   }

//   static Future<User> getUserLocal() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getString('user') != null) {
//       User user = userFromJson(prefs.getString('user'));
  
//       return user;
//     } else {
//       return null;
//     }
//   }

//   static Future<Settings> getSettingsLocal() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getString('settings') != null) {
//       Settings settings = settingsFromJson(prefs.getString('settings'));
//       return settings;
//     } else {
//       return null;
//     }
//   }

//   static Future<void> signOut() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     FirebaseAuth.instance.signOut();
//   }

//   static Future<void> forgotPasswordEmail(String email) async {
//     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//   }

//   static String getExceptionText(Exception e) {
//     if (e is PlatformException) {
//       switch (e.message) {
//         case 'There is no user record corresponding to this identifier. The user may have been deleted.':
//           return 'User with this email address not found.';
//           break;
//         case 'The password is invalid or the user does not have a password.':
//           return 'Invalid password.';
//           break;
//         case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
//           return 'No internet connection.';
//           break;
//         case 'The email address is already in use by another account.':
//           return 'This email address already has an account.';
//           break;
//         default:
//           return 'Unknown error occured.';
//       }
//     } else {
//       return 'Unknown error occured.';
//     }
//   }

// }